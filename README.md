# PicsCollection

**PicsCollection is an application which collects photos from your Instagram account and displays in this app. It provides the amazing user experience. PicsCollection supports a slideshow and image viewer that includes double-tap to zoom, animated zooming presentation, interactive transition flick and more…**

## Key Features:

- One time login
- Pull down to reload the image list with animation
- Display image list with animation
- Multiple Language Support(English | French | Danish | German | Dutch)
- Switch between list view and grid view of images with animation
- Double tap to zoom
- Zoom In/Out with animations
- Display images from Instagram with animations
- Image share option
- Swipe left/right for next/previous photos
- Swipe up/down to close the full-screen imageview
- Supported Portrait and Landscape orientations
- Logout

## How to run the project?

- Make sure you have an active internet connection and connected with a Physical device or you can use Xcode Simulator too.
- download or clone the project
- Open .xcworkspace file from your project folder
- Run the project from Xcode

    
## Application Screenshots

|Portrait (iPhone 6)|Landscape (iPhone 6)|
|:---:|:---:|
|![iphonep](/Github_data/iPhoneP.gif))|![iPhoneL.gif](/Github_data/iPhoneL.gif)|

|Portrait (iPad Air)|Landscape (iPad Air)|
|:---:|:---:|
|![iPadP.gif](/Github_data/iPadP.gif)|![iPadL.gif](/Github_data/iPadL.gif)|

## iPhone Portrait :
![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhonePWelcome.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhonePSideMenu.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhonePListView.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhonePGridView.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhonePChooseLang.png)


## iPhone Landscape:
![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhoneLWelcome.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhoneLSideMenu.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPhoneLListView.png)


## iPad Portrait:
![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPadPWelcome.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPadPSideMenu.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPadPListView.png)


## iPad Landscape:

![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPadLSideMenu.png)            ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/iPadLListView.png)


## Instagram Authentication Details

> Currently the client registered on Instagram Developer portal is in Sandbox mode, so if you want to Authenticate using your Instagram account then you need to perform certain steps as mentioned below.

###### Steps to Register a New Client On Instagram Developer Portal

- Go to [Instagram Developer](https://www.instagram.com/developer/)
- Login with your Instagram account credential details
- Click on the **Register a New Client**
- Submit required details
- It will provide details such as **Client ID**, **Client Secret**(Refer below screenshot)


![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/create_client.png)


- **_Important_**: In Security tab, you need to specify Redirect URI, which should be exactly similar which you are going to write in your code and uncheck **Disable implicit OAuth:** checkmark
- Click on **Update Client**(Refer below screenshot)


![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/security_update.png)


- Sandbox tab: As you have created a new client, you will be added there by default. So now you can use the application via Instagram Authentication. If you want other users to use your application then you need to add their Instagram Username and those users need to accept your application invitation by login into Instagram Developer -> Sandbox Invites -> Accept Invitation(Refer below screenshots)

![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/accept.png)


![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/accepted_invitation.png)


- **_Update Constant.swift file in your project_**:
````
struct InstagramIDs {
    static let kInstaAuthURL = "https://api.instagram.com/oauth/authorize/"
    static let kInstaApiURL  = "https://api.instagram.com/v1/users/"
    static let kInstaClientID  = "YOUR_CLIENT_ID"
    static let kInstaClientSecret = "YOUR_CLIENT_SECRET"
    static let kInstaRedirectURI = "YOUR_REDIRECT_URI"
    static let kInstaAccessToken =  "access_token"
    static let kInstaScope = "basic"
    static let kInstaRange = "#access_token="
    static let kInstaDenied = "=user_denied"
}
````
    
## Ackowledgement

This application has used other third party libraries available on GitHub as mentioned below:

- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [ReachabilitySwift](https://github.com/ashleymills/Reachability.swift)
- [SDWebImage](https://github.com/rs/SDWebImage)
- [DisplaySwitcher](https://github.com/Yalantis/DisplaySwitcher)
- [CollieGallery](https://github.com/gmunhoz/CollieGallery)
- [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD)
- [SideMenu](https://github.com/jonkykong/SideMenu)
- [ViewAnimator](https://github.com/marcosgriselli/ViewAnimator)

## Coding Standards Implemented

- MVC Architecture
- Swift Language(Version: 4.1)
- Followed Apple Human User Interface Guidelines
- Used Pods for other third-party libraries
- Used Asset Catalog for Images used in the application
- App Icon and Launch Image from Asset Catalog
- Well structured code
- Proper code commenting
- Used //MARK: to mark a section of my code
- Implemented Constant file to store global constants
- Global files to increase reusability of code
- Checked Internet Connectivity
- Managed caching of images for smooth user experience
- Tried to follow double optional(??) instead of compulsory(!) pattern as and when possible to avoid unnecessary crashes
- The project contains Code Documentation same as Apple Documentation

**Happy Coding! Cheers!!** 🥂 

## How to Contribute?

Have an idea? Found a bug? See [how to contribute](https://github.com/igatsha/PicsCollection/blob/master/Github_data/CONTRIBUTION.md). Every small or large contribution to this project is appreciated.
    
## Author
You can find more about me here : [Gati Shah](https://igati.tech)

If you wish to contact me, 
Email at: [connect@igati.tech](connect@igati.tech)

Reach me on: [LinkedIn](https://www.linkedin.com/in/igatitech/)

## License
Copyright 2020 iGatiTech

This project is distributed under the terms & conditions of [MIT License](https://github.com/igatitech/PicsCollection/blob/master/LICENSE).
