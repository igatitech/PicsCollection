# PicsCollection

**PicsCollection is an application which collects photos from your Instagram account and displays in this app. It provides the amazing user experience. PicsCollection supports a slideshow and image viewer that includes double-tap to zoom, animated zooming presentation, interactive transition flick and more…**

## Key Features:

- One time login
- Pull down to reload the image list
- Display image list with animation
- Switch between listview and gridview of images
- Double tap to zoom
- Zoom In/Out with animations
- Display images from Instagram with animations
- Image share option
- Swipe left/right for next/previous photos
- Swipe up/down to close the full-screen imageview
- Supported Portrait and Landscape mode
- Logout

## How to run the project?

- Make sure you have an active internet connect and connected with Physical device or you can use Xcode Simulator too.
- download or clone the project
- Open .xcworkspace file from your project folder
- Run the project from Xcode

    
## Application Screenshots

![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/WelcomiPhoneP.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/SideMenuiPhoneP.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/SideMenuiPadP.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/ListViewiPhoneP.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/ListViewiPhoneL.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/ListViewiPadL.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/GridViewiPhoneP.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/GridViewiPhoneL.png) ![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/GridViewiPadP.png)


## Instagram Authentication Details

> Currently the client registered on Instagram Developer portal is in Sandbox mode, so if you want to Authenticate using your Instagram account then you need to perform certatin steps as mentioned-below.

###### Steps to Register a New Client On Instagram Developer Portal

- Go to [Instagram Developer](https://www.instagram.com/developer/)
- Login with your Instagram account credential details
- Click on **Register a New Client**
- Submit required details
- It will provide details such as **Client ID**, **Client Secret**(Refer below screenshot)


![alt text](https://github.com/igatsha/PicsCollection/blob/master/Github_data/create_client.png)


- **_Important_**: In Security tab you need to specify Redirect URI, which should be exactly similar which you are going to write in your code and uncheck **Disable implicit OAuth:** checkmark
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
- [FBLikeLayout](https://github.com/gringoireDM/FBLikeLayout)
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

## How to Contribute?

Have an idea? Found a bug? See [how to contribute](https://github.com/igatsha/PicsCollection/blob/master/Github_data/CONTRIBUTION.md). Every small or large contribution to this project is appreciated.
    
## License
Copyright 2018 Gati Shah

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
