
//
//  NetworkManager.swift
//  WooStudio
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Reachability
import SVProgressHUD

//MARK:- Properties
let baseURL = "https://api.instagram.com/"
let accepTableStatusCodes = 200 ... 299

//MARK:- Endpoints
enum EndPoint {
    case Recent(accessToken : String),Logout,NextPageData(urlNextPage : String)
    var rawValue: String {
        get {
            switch self {
            case .Recent(let accessToken):
                return "v1/users/self/media/recent/?access_token=\(accessToken)"
                
            case .Logout:
                return "accounts/logout"
                
            case .NextPageData(let urlNextPage):
                return "\(urlNextPage)"
            }
        }
    }
}

class NetworkManager{
 
    /**
     request function is used to make an API call via Alamofire.
     
     - Parameter showloader: true/false
     - Parameter url: API Url
     - Parameter method: Get/Post/Put
     - Parameter parameter: Dictionary of request parameters
     - Returns: Success JSON
     - Returns: Failure Error Code
    */
    class func request(showloader : Bool,url : EndPoint,method : HTTPMethod,parameters : [String : Any],success:@escaping (JSON) -> Void,failure:@escaping (Int?) -> Void){
     
        if Reachability()?.connection != .none {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            if (showloader) {
                 SVProgressHUD.show()
            }
          
            let encoding : ParameterEncoding = URLEncoding.default
            
            print(parameters)
            print(baseURL + url.rawValue)
          
                Alamofire.request(
                    URL(string: baseURL + url.rawValue)!,
                    method: method,
                    parameters: parameters,encoding: encoding)
                    .responseJSON { (response) -> Void in
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        print(response.response?.statusCode ?? "not found!")
                        print(response.result.value as Any)
                        if let statusCode = response.response?.statusCode
                        {
                            switch statusCode{
                            case accepTableStatusCodes:
                                let responseObject = JSON(response.result.value as Any)
//                                guard let _ = responseObject.dictionaryObject else{
//                                    DELEGATE.window?.rootViewController?.showAlert(strTitle: alerts.error, strMsg: alerts.somethingWrong)
//                                    failure(response.response?.statusCode)
//                                    return
//                                }
                                success(responseObject)
                                break
                                
                            default:
                                DELEGATE.window?.rootViewController?.showAlert(strTitle: alerts.error, strMsg: alerts.somethingWrong)
                                failure(response.response?.statusCode)
                                break
                            }
                        }
                //hide indicator
                if (showloader) {
                    SVProgressHUD.dismiss()
                }
            }
        }else{
            //display no internet available message
            DELEGATE.window?.rootViewController?.showAlert(strTitle: alerts.networkError, strMsg: alerts.noInternetMsg)
        }
    }    
}


