//
//  SideMenuHeader.swift
//  WooStudio
//
//  Created by Gati Shah on 7/15/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import SideMenu

/**
 The purpose of 'SideMenuHeader' view is to configure side menu header.
 
 There's matching scene in the *SideMenuHeader.xib* file. Go to Interface Builder for details.
 
 The 'SideMenuHeader' class is a subclass of the 'UIView'.
 */

class SideMenuHeader: UIView {
    
    //MARK:- Outlets
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var imageUser : UIImageView!
    @IBOutlet weak var labelFullName : UILabel!
    @IBOutlet weak var labelUserName : UILabel!
    @IBOutlet weak var viewSep : UIView!
    
    //MARK:- Properties
    var vController : SideMenu?
    
    class func instanceFromNib() -> SideMenuHeader {
        return UINib(nibName: ViewIdentifier.SideMenuHeader, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SideMenuHeader
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.setUpView()
        
    }
    
    //MARK:- Custom Method
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     */
    func setUpView() {
        
        DispatchQueue.main.async {
            self.imageUser.layer.cornerRadius = self.imageUser.frame.size.width / 2
            self.imageUser.layer.masksToBounds = true
        }
        labelFullName.font = GetAppFont(FontType: .Bold, FontSize: .Large)
        labelUserName.font = GetAppFont(FontType: .Regular, FontSize: .Small)
        viewSep.backgroundColor = UIColor.black
    }

    //MARK:- Set Data
    
    /**
     setFullName function is used to set full name of user
     
     - Parameter strFullname: Full name parameter string
     - Returns: nil
    */
    func setFullName(strFullname : String) {
        
        labelFullName.setUpLabel(title: strFullname, titleColor: .darkGray)
    }
    
    /**
     setUserName function is used to set username of user
     
     - Parameter strUserName: Username parameter string
     - Returns: nil
    */
    func setUserName(strUserName : String) {
        
        labelUserName.setUpLabel(title: strUserName, titleColor: .orange)
    }
}
