//
//  Functions.swift
//  WooStudio
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import Foundation

//MARK:- Fonts
/**
 printFonts function is used to print Font Family Name to use in Application
 
 - Parameter nil
 - Returns: nil
 */
func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName)
        print("Font Names = [\(names)]")
    }
}

/**
 GetAppFont function is used to set Font with it's size
 
 - Parameter FontType: choose font from AppFont Enum
 - Parameter FontSize: choose font from FontSize Enum
 - Returns: nil
 */
func GetAppFont(FontType : AppFont,FontSize : FontSize) -> UIFont{
    
    guard let font = UIFont(name: FontType.rawValue, size: FontSize.rawValue) else {
        print("Font with provided font name not found!")
        return UIFont.systemFont(ofSize: FontSize.rawValue)
    }
    return font
}

//MARK:- Controller

/**
 GetViewController function is used to get Controller by defining storyboard and it's identifier
 
 - Parameter StoryBoard: choose storyboard identifier from StoryBoards Enum
 - Parameter Identifier: choose controller identifier from ControllerIdentifier Enum
*/
func GetViewController(StoryBoard : Storyboards,Identifier : ControllerIdentifier) ->UIViewController?{
  
    return UIStoryboard(name: StoryBoard.rawValue, bundle: nil).instantiateViewController(withIdentifier: Identifier.rawValue)
  
}

//MARK:- UserDefaults Methods

/**
 saveStringToDefaults function is used to save string to UserDefaults
 
 - Parameter string: string value which needs to be stored in UserDefaults
 - Parameter key: choose key name from CacheKeys Enum
 - Returns: nil
 */
func saveStringToDefaults(string : String,key : CacheKeys){
    UserDefaults.standard.setValue(string,forKey: key.rawValue)
    UserDefaults.standard.synchronize()
}

/**
 getStringFromDefaults function is used to get string which is stored in UserDefualts
 
 - Parameter key: choose key name from CacheKeys Enum
 - Returns: String
 */
func getStringFromDefaults(key : CacheKeys) ->String?{
    
    if let string = UserDefaults.standard.value(forKey: key.rawValue) as? String {
        return string
    }
    return nil
}

/**
 resetDefaults function is used to remove all the data stored in UserDefaults
 
 - Parameter nil
 - Returns: nil
 */
func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        defaults.removeObject(forKey: key)
    }
    defaults.synchronize()
    clearCookies()
}

//MARK:- Cookies

/**
 clearCookies function is used to clear cookies
 
 - Parameter nil
 - Returns: nil
 */
func clearCookies() {
    
    let cookieStore = HTTPCookieStorage.shared
    guard let cookies = cookieStore.cookies, cookies.count > 0 else { return }
    
    for cookie in cookies {
        if cookie.domain == "www.instagram.com" || cookie.domain == "api.instagram.com" {
            cookieStore.deleteCookie(cookie)
        }
    }
    URLCache.shared.removeAllCachedResponses()
}




