//
//  HomeVC.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import SDWebImage
import FBLikeLayout
import CollieGallery
import ViewAnimator

/**
 The purpose of the `HomeVC` view controller is to display user's images from their Instagram account.
 
 There's a matching scene in the Home.storyboard file. Go to Interface Builder for details.
 
 The `HomeVC` class is a subclass of the `UIViewController`, and it conforms to the `UICollectionViewDelegate`, `UICollectionViewDatasource`,`UICollectionViewDelegateFlowLayout` protocol.
 */

class HomeVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var collectionPics : UICollectionView!
    @IBOutlet weak var labelNoData : UILabel!
    
    //MARK:- Properties
    private let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    var mainData : MainData?
    var pictureData : [UserData]?
    
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
        //...Navigate to Authentication Screen if Logout
        if isLogout {
            isLogout = false
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //...Set up dynamic collection cell width/height
        if !(collectionPics?.collectionViewLayout is FBLikeLayout) {
            let layout = FBLikeLayout()
            layout.minimumInteritemSpacing = 4
            let value = ((collectionPics?.contentInset.left ?? 0.0) + (collectionPics?.contentInset.right ?? 0.0) + 8)
            layout.singleCellWidth = ((min((collectionPics?.bounds.size.width)!, (collectionPics?.bounds.size.height)!) - value) / 3.0)
            layout.maxCellSpace = 3
            layout.forceCellWidthForMinimumInteritemSpacing = true
            layout.fullImagePercentageOfOccurrency = 50
            collectionPics?.collectionViewLayout = layout
            collectionPics?.reloadData()
        }
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
    
    //MARK:- Custom Methods
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     */
    func setUpView() {
        
        //...Fetch user picture API call
        fetchUserPicturesAPICall()
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
    func dataValidation() {
        
        if pictureData?.count ?? 0 <= 0 {
            collectionPics.isHidden = true
            labelNoData.isHidden = false
        } else {
            collectionPics.isHidden = false
            labelNoData.isHidden = true
        }
        collectionPics.reloadData()
        collectionPics.performBatchUpdates({
            UIView.animate(views: self.collectionPics.orderedVisibleCells,
                           animations: self.animations, completion: {
            })
        }, completion: nil)
    }
    
    //MARK:- API Call
    
    /**
     fetchUserPicturesAPICall function is used to fetch user's pictures from their Instagram account
     
     - Parameter nil
     - Returns: nil
    */
    func fetchUserPicturesAPICall() {
        
        NetworkManager.request(showloader: true, url: .Recent(accessToken: getStringFromDefaults(key: .userAuthToken)!), method: .get, parameters: ["":""], success: { (response) in
            if let dict = response.dictionaryObject as NSDictionary? {
                self.mainData = MainData(dictionary: dict)
                self.pictureData = self.mainData?.data
            }
            self.saveUserData()
            self.dataValidation()
        }, failure: {_ in
        })
    }
    
    /**
     loadMoreData function will be called when there are more data available of any user. It will call next pagination.
     
    - Parameter nil
     - Returns: nil
    */
    func loadMoreData() {
        
        NetworkManager.request(showloader: true, url: .NextPageData(urlNextPage: self.mainData?.pagination?.next_url ?? ""), method: .get, parameters: ["":""], success: { (response) in
            
            if let dict = response.dictionaryObject as NSDictionary? {
                self.mainData = MainData(dictionary: dict)
                for dict in (self.mainData?.data)! {
                    self.pictureData?.append(dict)
                }
            }
            self.collectionPics.reloadData()
            self.collectionPics.performBatchUpdates({
                UIView.animate(views: self.collectionPics.orderedVisibleCells,
                               animations: self.animations, completion: {
                })
            }, completion: nil)
        }, failure: {_ in
        })
    }
}

//MARK:- UICollectionView Datasource and Delegate
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pictureData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionPics.dequeueReusableCell(withReuseIdentifier: CellIdentifier.ImageCollection, for: indexPath) as! ImageCollectionCell
        let url = URL(string: pictureData?[indexPath.item].images?.low_resolution?.url ?? "")
        cell.setImage(urlImage: url!)
        cell.setLikesLabel(likesCount: pictureData?[indexPath.item].likes?.count ?? 0)
        if let _ = mainData?.pagination?.next_url {
            if indexPath.item == mainData?.data?.count ?? 0 - 1 {  //numberofitem count
                loadMoreData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let pixelWidth : Int = pictureData?[indexPath.item].images?.low_resolution?.width ?? 0
        let pixelHeight : Int = pictureData?[indexPath.item].images?.low_resolution?.height ?? 0
        return CGSize(width: pixelWidth, height: pixelHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.OpenGallery(withIndex: indexPath.item)
    }
}
