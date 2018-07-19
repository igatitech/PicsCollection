//
//  AppTourVC.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/16/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import AVKit

/**
 The purpose of the `AppTourVC` view controller is to show application overview to user.
 
 There's a matching scene in the Home.storyboard file. Go to Interface Builder for details.
 
 The `HomeVC` class is a subclass of the `UIViewController`
 */

class AppTourVC: UIViewController {

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBActions
    
    /**
     This click_Back will call when user clicks on back button.
     It will redirect user to previous screen
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_buttonBack(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     This click_buttonAppTour will call when user clicks on play button.
     It will open a video of application overview
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_buttonAppTour(_ sender : Any) {
        
        //...Play App Tour Video
        if let path = Bundle.main.path(forResource: StringVideo.vdApp, ofType: StringVideo.vdExt) {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            present(videoPlayer, animated: true) {
                video.play()
            }
        }
    }
}
