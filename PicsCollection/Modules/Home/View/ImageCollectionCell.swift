//
//  ImageCollectionCell.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import SDWebImage

/**
 The purpose of 'ImageCollectionCell' tableview cell is to configure tableview cell.
 
 There's matching scene in the *Home.storyboard* file. Go to Interface Builder for details.
 
 The 'ImageCollectionCell' class is a subclass of the 'UITableViewCell'.
 */

class ImageCollectionCell: UICollectionViewCell {

    //MARK:- IBOutlets
    @IBOutlet var imageInsta : UIImageView!
    @IBOutlet var labelLikes : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
    }
    
    class func instanceFromNib() -> ImageCollectionCell {
        return UINib(nibName: CellIdentifier.ImageCollection, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ImageCollectionCell
    }
    
    //MARK:- Custom Method
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     */
    func setUpView() {
        labelLikes.font = GetAppFont(FontType: .Bold, FontSize: .Small)
    }
    
    //MARK:- Set Data
    
    /**
     setImage function is used to set images from Instagram
     
     - Parameter urlImage: URL of low resolution image
     - Returns: nil
    */
    func setImage(urlImage : URL) {
        
        imageInsta.sd_setImage(with: urlImage, placeholderImage: UIImage(named: StringImages.imgPlaceholder))
    }
    
    /**
     setLikesLabel function is used to set number of likes counter
     
     - Parameter likesCount: Number of likes counter
     - Returns: nil
    */
    func setLikesLabel(likesCount : Int){
        
        labelLikes.text = "\(likesCount)"
    }
}
