//
//  HomeVC.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import SDWebImage
import CollieGallery
import ViewAnimator
import Reachability
import DisplaySwitcher

private let animationDuration: TimeInterval = 0.3
private let listLayoutStaticCellHeight: CGFloat = 80
private let gridLayoutStaticCellHeight: CGFloat = 150

/**
 The purpose of the `HomeVC` view controller is to display user's images from their Instagram account.
 
 There's a matching scene in the Home.storyboard file. Go to Interface Builder for details.
 
 The `HomeVC` class is a subclass of the `UIViewController`, and it conforms to the `UICollectionViewDelegate`, `UICollectionViewDatasource`,`UICollectionViewDelegateFlowLayout` protocol.
 */

class HomeVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var collectionPics : UICollectionView!
    @IBOutlet fileprivate weak var buttonRotation: SwitchLayoutButton!
    
    //MARK:- Properties
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    var mainData : MainData?
    var pictureData : [UserData]?
    var refresher : UIRefreshControl!
    var isTransitionAvailable = true
    var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    var layoutState: LayoutState = .list
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //...Add orientation observer
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //...Navigate to Authentication Screen if Logout
        if isLogout {
            isLogout = false
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //...Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK:- IBActions
    
    /**
     This click_SideMenu will call when user clicks on side menu button.
     It will display side menu
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_SideMenu(_ sender : Any) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: NavigationControllerIdentifier.SideMenuNavigationController.rawValue) as! SideMenuNavigationController
        self.present(VC1, animated:true, completion: nil)
    }
    
    /**
     This click_Rotation will call when user clicks on rotation switch button.
     It will change screen display layout
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_Rotation(_ sender: AnyObject) {
        if !isTransitionAvailable {
            return
        }
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionPics!, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionPics!, destinationLayout: listLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
        buttonRotation.isSelected = layoutState == .list
        buttonRotation.animationDuration = animationDuration
    }
    
    //MARK:- Custom Methods
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     
     - Parameter nil
     - Returns: nil
     */
    func setUpView() {
        
        //...CollectionView Setup
        buttonRotation.isSelected = true
        setupCollectionView()
        
        //...Fetch user picture API call
        fetchUserPicturesAPICall(isShowLoading: true)
        
        //...Pull to refresh Control
        self.refresher = UIRefreshControl()
        self.collectionPics!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.white
        self.refresher.addTarget(self, action: #selector(reloadCollectionData), for: .valueChanged)
        self.collectionPics!.addSubview(refresher)
    }
    
    /**
     setupCollectionView function is used to setup collectionview.
     
     - Parameter nil
     - Returns: nil
     */
    func setupCollectionView() {
        collectionPics.collectionViewLayout = listLayout
        collectionPics.register(UserCollectionViewCell.cellNib, forCellWithReuseIdentifier:UserCollectionViewCell.id)
    }
    
    /**
     rotated function is a selector method of orientation observer and it will be called when screen orientation will be changed.
     
     - Parameter nil
     - Returns: nil
     */
    @objc func rotated() {
        
        loadCollectionWithAnimations()
    }
    
    /**
     OpenGallery function is used to display images in Full Screens with Zoom In/Out, Swipe left/right and share options
     
     - Parameter withIndex : index of picture been clicked
     - Returns: nil
    */
    func OpenGallery(withIndex : Int){
        guard let productImages = self.mainData?.getUserImages() else {
            return
        }
        let gallery = CollieGallery(pictures: productImages)

        gallery.presentInViewController(self)
        gallery.scrollToIndex(withIndex)
    }
    
    /**
     saveUserData function is used for saving user's basic information such as Fullname, Username and Profile picture details into Userdefaults
     
     - Parameter nil
     - Returns: nil
    */
    func saveUserData() {
        if pictureData?.count ?? 0 > 0 {
            saveStringToDefaults(string: pictureData?[0].user?.full_name ?? "", key: .fullname)
            saveStringToDefaults(string: pictureData?[0].user?.username ?? "", key: .userName)
            saveStringToDefaults(string: pictureData?[0].user?.profile_picture ?? "", key: .profilePicture)
        }
    }
    
    /**
     dataValidation function is used to check whether app has data to display or not, If it has data then it will load with Animations
     
     - Parameter nil
     - Returns: nil
    */
    func loadCollectionWithAnimations() {
        
        collectionPics.reloadData()
        collectionPics.performBatchUpdates({
            UIView.animate(views: self.collectionPics.orderedVisibleCells,
                           animations: self.animations, completion: {
            })
        }, completion: nil)
    }
    
    /**
     reloadData function will be called on Pull to Refresh
     
     - Parameter nil
     - Returns: nil
    */
    @objc func reloadCollectionData() {
        
        if Reachability()?.connection != .wifi && Reachability()?.connection != .cellular {
                self.stopRefresher()
        } else {
            //...Fetch user picture API call
            fetchUserPicturesAPICall(isShowLoading: false)
        }
    }
    
    /**
     stopRefresher function is used to stop refresh control
     
     - Parameter nil
     - Returns: nil
    */
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    //MARK:- API Call
    
    /**
     fetchUserPicturesAPICall function is used to fetch user's pictures from their Instagram account
     
     - Parameter nil
     - Returns: nil
    */
    func fetchUserPicturesAPICall(isShowLoading : Bool) {
        
        NetworkManager.request(viewController: self, showloader: isShowLoading, url: .Recent(accessToken: getStringFromDefaults(key: .userAuthToken)!), method: .get, parameters: ["":""], success: { (response) in
            self.stopRefresher()
            if let dict = response.dictionaryObject as NSDictionary? {
                self.mainData = MainData(dictionary: dict)
                self.pictureData = self.mainData?.data
            }
            self.saveUserData()
            self.loadCollectionWithAnimations()
        }, failure: {_ in
        })
    }
    
    /**
     loadMoreData function will be called when there are more data available of any user. It will call next pagination.
     
    - Parameter nil
     - Returns: nil
    */
    func loadMoreData() {
        
        NetworkManager.request(viewController: self, showloader: true, url: .NextPageData(urlNextPage: self.mainData?.pagination?.next_url ?? ""), method: .get, parameters: ["":""], success: { (response) in
            
            if let dict = response.dictionaryObject as NSDictionary? {
                self.mainData = MainData(dictionary: dict)
                for dict in (self.mainData?.data)! {
                    self.pictureData?.append(dict)
                }
            }
            self.loadCollectionWithAnimations()
        }, failure: {_ in
        })
    }
}

//MARK:- UICollectionView Datasource and Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (pictureData?.count == 0) {
            collectionPics.setEmptyMessage(StringConstant.noData)
        } else {
            collectionPics.restore()
        }
        return pictureData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserCollectionViewCell.id, for: indexPath) as! UserCollectionViewCell
        if layoutState == .grid {
            cell.setupGridLayoutConstraints(1, cellWidth: cell.frame.width)
        } else {
            cell.setupListLayoutConstraints(1, cellWidth: cell.frame.width)
        }
        cell.index = indexPath.item
        cell.mainData = mainData
        if let _ = mainData?.pagination?.next_url {
            if indexPath.item == mainData?.data?.count ?? 0 - 1 {  //numberofitem count
                loadMoreData()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.OpenGallery(withIndex: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTransitionAvailable = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isTransitionAvailable = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
