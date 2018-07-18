//
//  Constant.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit

//MARK:- Properties
var isLogout = false

//MARK:- String Constants

struct StringConstant {
    static let noData = "No Data Available!"
}
//MARK:- Intro Screen String Constants
struct StringIntro {
    static let title1 = "Welcome to Pics Collection"
    static let title2 = "Amazing Features"
    static let title3 = "Every Little Help!"
    static let desc1 = "Pics Collection : See More, Do More!"
    static let desc2 = "There are everything, Instagram can do! For something else, there's Pics Collection"
    static let desc3 = "\"View | Stretch | Share\""
}

struct StringImages {
    static let imgIntro = "picsgif"
    static let imgExt = "gif"
    static let imgPlaceholder = "placeholder"
    static let imgLogout = "logout"
    static let imgAppTour = "apptour"
}

struct StringSideMenu {
    static let logout = "Logout"
    static let appTour = "App Tour"
}

struct InstagramIDs {
    static let kInstaAuthURL = "https://api.instagram.com/oauth/authorize/"
    static let kInstaApiURL  = "https://api.instagram.com/v1/users/"
    static let kInstaClientID  = "140e49b5dcd24c6f829fc08db61be6a9"
    static let kInstaClientSecret = "2792d3264b8b41908f8333a987e388fd"
    static let kInstaRedirectURI = "http://localhost"
    static let kInstaAccessToken =  "access_token"
    static let kInstaScope = "basic"//+public_content"
    //+follower_list+likes+comments+relationships
    static let kInstaRange = "#access_token="
    static let kInstaDenied = "=user_denied"
}

//MARK:- Storyboards
enum Storyboards : String {
    case Authenticate = "Authenticate"
    case Home = "Home"
}

//MARK:- ViewControllerIdentifier
enum ControllerIdentifier : String {
    case Authenticate = "AuthenticateVC"
    case WebView = "WebViewVC"
    case Home = "HomeVC"
    case AppTour = "AppTourVC"
}

//MARK:- CellIdentifier
struct CellIdentifier {
    static let ImageCollection = "ImageCollectionCell"
    static let SideMenu = "SideMenuCell"
}

//MARK:- ViewIdentifier
struct ViewIdentifier {
    static let SideMenuHeader = "SideMenuHeader"
}

//MARK:- NavigationControllerIdentifier
enum NavigationControllerIdentifier : String {
    case AuthNavigationController = "AuthNavigationController"
    case SideMenuNavigationController = "SideMenuNavigationController"
}

//MARK:- FontSize
enum FontSize : CGFloat {
    case Big = 26.0
    case BelowBig = 24.0
    case ExtraLarge = 20.0
    case Large = 18.0
    case Medium = 16.0
    case Regular = 14.0
    case Small = 12.0
    case ExtraSmall = 10.0
}

//MARK:- AppFont
enum AppFont : String {
    case Bold = "Optima-Bold"
    case BoldItalic = "Optima-BoldItalic"
    case ExtraBlack = "Optima-ExtraBlack"
    case Italic = "Optima-Italic"
    case Regular = "Optima-Regular"
}

//MARK:- UserDefault CacheKeys
enum CacheKeys : String {
    case userAuthToken = "authToken"
    case userName = "username"
    case fullname = "fullname"
    case profilePicture = "profilePicture"
}

//MARK:- AlertView Strings
struct alerts {
    static let title = "Pics Collection"
    static let logout = "Are you sure, you want to logout?"
    static let OK = "OK"
    static let delete = "DELETE"
    static let cancel = "CANCEL"
    static let yes = "YES"
    static let no = "NO"
    static let error = "Error"
    static let networkError = "Network Error"
    static let comingSoon = "Coming Soon!"
    static let noInternetMsg = "Internet is not available. Please try again."
    static let somethingWrong = "Something went wrong! Please try again later"
}
