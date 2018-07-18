//
//  Extension.swift
//  WooStudio
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    func setUpLabel(title:String,titleColor:UIColor,titleFont:UIFont? = nil,attributeTitle:NSAttributedString? = nil) {
       
        self.textColor = titleColor
        
        if titleFont != nil{
            self.font = titleFont
        }
 
        if attributeTitle != nil {
            self.attributedText = attributeTitle
        }else {
             self.text = title
        }
    }
}

extension UIViewController {
    
    func showAlert(strTitle : String, strMsg : String) {
        let alert = UIAlertController.init(title: strTitle, message: strMsg, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UINavigationController {
    
    func backToViewController(vc: Any)  {
        // iterate to find the type of vc
    
        for element in viewControllers as Array {
            if element.isKind(of: vc as! AnyClass) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = GetAppFont(FontType: .Bold, FontSize: .BelowBig)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
