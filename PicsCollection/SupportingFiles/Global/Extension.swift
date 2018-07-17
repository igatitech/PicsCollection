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
    
        print(viewControllers)
        for element in viewControllers as Array {
            if element.isKind(of: vc as! AnyClass) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
