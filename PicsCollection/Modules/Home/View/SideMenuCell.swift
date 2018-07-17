//
//  SideMenuCell.swift
//  WooStudio
//
//  Created by Gati Shah on 7/15/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit

/**
 The purpose of 'SideMenuCell' tableview cell is to configure tableview cell.
 
 There's matching scene in the *SideMenuCell.xib* file. Go to Interface Builder for details.
 
 The 'SideMenuCell' class is a subclass of the 'UITableViewCell'.
 */

class SideMenuCell: UITableViewCell {

    //MARK:- Outlets -
    
    @IBOutlet weak var viewSub : UIView!
    @IBOutlet weak var imageIcon : UIImageView!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var viewSep : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }

    class func instanceFromNib() -> SideMenuCell {
        return UINib(nibName: CellIdentifier.SideMenu, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SideMenuCell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Custom Methods
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     */
    func setUpView() {
        
        labelTitle.font = GetAppFont(FontType: .Regular, FontSize: .Medium)
        viewSep.backgroundColor = UIColor.black
    }
    
    //MARK:- Set Data
    
    /**
     setIconImage function is used to set icons in Side Menu
     
     - Parameter strImage: Image name parameter string
     - Returns: nil
    */
    func setIconImage(strImage : String) {
        
        imageIcon.image = UIImage(named: strImage)
    }
    
    /**
     setTitleName function is used to set titles in Side Menu
     
     - Parameter strTitle: Title name parameter string
     - Returns: nil
    */
    func setTitleName(strTitle : String){
        
        labelTitle.setUpLabel(title: strTitle, titleColor: .black)
    }
}
