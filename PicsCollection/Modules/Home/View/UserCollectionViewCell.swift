//
//  UserCollectionViewCell.swift
//  YALLayoutTransitioning
//
//  Created by Gati Shah on 7/18/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import DisplaySwitcher
import SDWebImage

private let avatarListLayoutSize: CGFloat = 80.0

/**
 The purpose of 'UserCollectionViewCell' collectionview cell is to configure collection cell.
 
 There's matching scene in the *UserCollectionViewCell.xib* file. Go to Interface Builder for details.
 
 The 'UserCollectionViewCell' class is a subclass of the 'UICollectionViewCell'.
 */

class UserCollectionViewCell: UICollectionViewCell, CellInterface {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var nameListLabel: UILabel!
    @IBOutlet weak var nameGridLabel: UILabel!
    @IBOutlet weak var statisticLabel: UILabel!
    
    // avatarImageView constraints
    @IBOutlet weak var avatarImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarImageViewHeightConstraint: NSLayoutConstraint!
    
    // nameListLabel constraints
    @IBOutlet var nameListLabelLeadingConstraint: NSLayoutConstraint! {
        didSet {
            initialLabelsLeadingConstraintValue = nameListLabelLeadingConstraint.constant
        }
    }
    
    // statisticLabel constraints
    @IBOutlet weak var statisticLabelLeadingConstraint: NSLayoutConstraint!
    
    var avatarGridLayoutSize: CGFloat = 0.0
    var initialLabelsLeadingConstraintValue: CGFloat = 0.0
    var pictureData : [UserData]? {
        didSet {
            setData()
        }
    }
    var index : Int!
    
    //MARK:- Set Data
    
    /**
     setData function is used to set data in collection view cell
     
     - Parameter nil
     - Returns: nil
     */
    
    func setData() {
        let url = URL(string: pictureData?[index].images?.low_resolution?.url ?? "")
        avatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: StringImages.imgPlaceholder))
        nameListLabel.text = pictureData?[index].user?.username
        nameGridLabel.text = pictureData?[index].user?.full_name
        let userPostsString = ("\(pictureData?[index].likes?.count ?? 0)" + " \(StringConstant.likes.localized()) • ")
        let userCommentsString = ("\(pictureData?[index].comments?.count ?? 0)" + " \(StringConstant.comments.localized())")
        statisticLabel.text = userPostsString + userCommentsString
    }
    
    //MARK:- Custom Methods
    
    func setupGridLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        avatarImageViewHeightConstraint.constant = ceil((cellWidth - avatarListLayoutSize) * transitionProgress + avatarListLayoutSize)
        avatarImageViewWidthConstraint.constant = ceil(avatarImageViewHeightConstraint.constant)
        nameListLabelLeadingConstraint.constant = -avatarImageViewWidthConstraint.constant * transitionProgress + initialLabelsLeadingConstraintValue
        statisticLabelLeadingConstraint.constant = nameListLabelLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListLabel.alpha = 1 - transitionProgress
        statisticLabel.alpha = 1 - transitionProgress
    }
    
    func setupListLayoutConstraints(_ transitionProgress: CGFloat, cellWidth: CGFloat) {
        avatarImageViewHeightConstraint.constant = ceil(avatarGridLayoutSize - (avatarGridLayoutSize - avatarListLayoutSize) * transitionProgress)
        avatarImageViewWidthConstraint.constant = avatarImageViewHeightConstraint.constant 
        nameListLabelLeadingConstraint.constant = avatarImageViewWidthConstraint.constant * transitionProgress + (initialLabelsLeadingConstraintValue - avatarImageViewHeightConstraint.constant)
        statisticLabelLeadingConstraint.constant = nameListLabelLeadingConstraint.constant
        backgroundGradientView.alpha = transitionProgress <= 0.5 ? 1 - transitionProgress : transitionProgress
        nameListLabel.alpha = transitionProgress
        statisticLabel.alpha = transitionProgress
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? DisplaySwitchLayoutAttributes {
            if attributes.transitionProgress > 0 {
                if attributes.layoutState == .grid {
                    setupGridLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
                    avatarGridLayoutSize = attributes.nextLayoutCellFrame.width
                } else {
                    setupListLayoutConstraints(attributes.transitionProgress, cellWidth: attributes.nextLayoutCellFrame.width)
                }
            }
        }
    }
}
