//
//  AuthenticateVC.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit

/**
 The purpose of the `AuthenticateVC` view controller is to allow user to navigate to Instagram page for Authentication and also some visual effects related to app.
 
 There's a matching scene in the Authenticate.storyboard file. Go to Interface Builder for details.
 
 The `AuthenticateVC` class is a subclass of the `UIViewController`, and it conforms to the `UIScrollViewDelegate` protocol.
 */

class AuthenticateVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var pageControlIntro : UIPageControl!
    @IBOutlet weak var scrollIntro : UIScrollView!
    @IBOutlet weak var imageIntro : UIImageView!
    @IBOutlet weak var buttonInsta : UIButton!
    
    //MARK:- Properties
    let arrTitles = [StringIntro.title1, StringIntro.title2, StringIntro.title3]
    let arrDesc = [StringIntro.desc1, StringIntro.desc2, StringIntro.desc3]
    var timerIntro : Timer?
    
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
        //...Start Timer
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //...Remove observer
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //...Stop Timer
        stopTimer()

    }
    
    //MARK:- IBActions
    
    /**
     This click_buttonInsta will call when user clicks on Instagram button.
     It will redirect user to Instagram page for Authentication
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_buttonInsta(_ sender : UIButton) {
        
        if getStringFromDefaults(key: .userAuthToken) != nil {
            guard let objHome = GetViewController(StoryBoard: .Home, Identifier: .Home) else {
                return
            }
            self.navigationController?.pushViewController(objHome, animated: true)
        } else {
            guard let objWebView = GetViewController(StoryBoard: .Authenticate, Identifier: .WebView) else {
                return
            }
            self.navigationController?.pushViewController(objWebView, animated: true)
        }
    }
    
    //MARK:- Custom Methods
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     
     - Parameter nil
     - Returns: nil
     */
    func setUpView() {
        
        //...Intro screen setup
        loadIntroScreens()
        
        //...Load Gif
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: StringImages.imgIntro, withExtension: StringImages.imgExt)!)
        imageIntro.image = UIImage.sd_animatedGIF(with: imageData)
        
        //...Add orientation observer
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    //MARK:- PageControl Methods
    
    /**
     pageChanged function will be called when user changes the pages of introduction screens
     
     - Parameter sender : a reference to the pagecontrol that has been touched
     - Returns: nil
    */
    @IBAction func pageChanged(_ sender: Any) {
        let pageNumber = pageControlIntro.currentPage
        var frame = scrollIntro.frame
        frame.origin.x = frame.size.width * CGFloat(pageNumber)
        frame.origin.y = 0
        scrollIntro.scrollRectToVisible(frame, animated: true)
    }
    
    /**
     loadIntroScreens function is used to setup Introduction screens.
     
     - Parameter nil
     - Returns: nil
    */
    func loadIntroScreens() {
        
        let pageCount : CGFloat = CGFloat(arrTitles.count)
        var labelTitle = UILabel()
        var labelDesc = UILabel()
        for subviews in scrollIntro.subviews {
            subviews.removeFromSuperview()
        }
        scrollIntro.contentSize = CGSize(width: self.view.frame.size.width * pageCount, height: self.view.frame.size.height)
        
        pageControlIntro.numberOfPages = Int(pageCount)
        
        for i in 0..<Int(pageCount) {
            labelTitle = UILabel(frame: CGRect(x: self.view.frame.size.width * CGFloat(i), y: 40, width: self.view.frame.size.width, height: 40))
            labelDesc = UILabel(frame: CGRect(x: (self.view.frame.size.width * CGFloat(i)) + 10, y: self.view.frame.size.height - 190, width: self.view.frame.size.width - 20, height: 50))
            
            labelTitle.textColor = UIColor.white
            labelTitle.font = GetAppFont(FontType: .Bold, FontSize: .ExtraLarge)
            labelTitle.textAlignment = .center
            labelTitle.text = arrTitles[i]
            self.scrollIntro.addSubview(labelTitle)
            
            labelDesc.textColor = UIColor.white
            labelDesc.numberOfLines = 0
            labelDesc.font = GetAppFont(FontType: .Bold, FontSize: .Medium)
            labelDesc.textAlignment = .center
            labelDesc.text = arrDesc[i]
            self.scrollIntro.addSubview(labelDesc)
        }
    }
    
    /**
     moveToNextPage function is used to turn on automatic slide through all Introduction screens
     
     - Parameter nil
     - Returns: nil
    */
    @objc func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollIntro.frame.width
        let maxWidth:CGFloat = pageWidth * CGFloat(arrTitles.count)
        let contentOffset:CGFloat = self.scrollIntro.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scrollIntro.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollIntro.frame.height), animated: true)
    }
    
    /**
     rotated function is a selector method of orientation observer and it will be called when screen orientation will be changed.
     
     - Parameter nil
     - Returns: nil
    */
    @objc func rotated() {
        
        loadIntroScreens()
    }
    
    /**
     startTimer function is used to enable autoscrolling in Introductino screens
     
     - Parameter nil
     - Returns: nil
    */
    func startTimer() {
      
        if timerIntro == nil {
            timerIntro = Timer.scheduledTimer(timeInterval: 2.85, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        }
    }
    
    /**
     stopTimer function is used to stop timer of autoscrolling Introduction screens
     
     - Parameter nil
     - Returns: nil
    */
    func stopTimer() {
        if timerIntro != nil {
            timerIntro?.invalidate()
            timerIntro = nil
        }
    }
}

//MARK:- UIScrollView Delegate
extension AuthenticateVC : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let viewWidth: CGFloat = scrollView.frame.size.width
        // content offset - tells by how much the scroll view has scrolled.
        let pageNumber = floor((scrollView.contentOffset.x - viewWidth / 50) / viewWidth) + 1
        pageControlIntro.currentPage = Int(pageNumber)
    }
}
