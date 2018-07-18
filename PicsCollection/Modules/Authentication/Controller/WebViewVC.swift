//
//  WebViewVC.swift
//  PicsCollection
//
//  Created by Gati Shah on 7/14/18.
//  Copyright © 2018 Gati Shah. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

/**
 The purpose of the `WebViewVC` view controller is to allow user to authenticate via Instagram and provide access of their personal details.
 
 There's a matching scene in the Authenticate.storyboard file. Go to Interface Builder for details.
 
 The `WebViewVC` class is a subclass of the `UIViewController`, and it conforms to the `WKNavigationDelegate` protocol.
 */

class WebViewVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var webViewLogin : WKWebView!
    
    // MARK: - Types
    typealias SuccessHandler = (_ accesToken: String) -> Void

    
    // MARK: - Properties
    private var success: SuccessHandler?
    var urlRequest : URLRequest?

    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IBActions
    
    /**
     This click_Back will call when user clicks on back button.
     It will redirect user to previous screen
     
     - Parameter sender: a reference to the button that has been touched
     - Returns: nil
     */
    @IBAction func click_Back(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Custom Methods
    
    /**
     setUpView function is used to setup default values, messages and UI related changes for the current class.
     
     - Parameter nil
     - Returns: nil
     */
    func setUpView() {
        
        if getStringFromDefaults(key: .userAuthToken) == nil {
            clearCache()
        }
        webViewLogin.navigationDelegate = self
        unSignedRequest()
    }
    
    /**
     unSignedRequest function is used to authenticate user via Instagram and get access token.
     
     - Parameter nil
     - Returns: nil
    */
    func unSignedRequest () {
        
        SVProgressHUD.show()
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [InstagramIDs.kInstaAuthURL,InstagramIDs.kInstaClientID,InstagramIDs.kInstaRedirectURI, InstagramIDs.kInstaScope ])
        urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        webViewLogin.load(urlRequest!)
    }
    
    /**
     clearCache function is used to clear all the stored sessions and cache memory.
     
     - Parameter nil
     - Returns: nil
    */
    func clearCache() {
        
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeCookies,WKWebsiteDataTypeSessionStorage])
        let date = NSDate(timeIntervalSince1970: 0)
        
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date as Date, completionHandler:{ })
    }
    
    /**
     checkRequestForCallbackURL function is used to fetch authentication token from URLRequest
     
     - Parameter request: URLRequest
     - Returns: nil
    */
    func checkRequestForCallbackURL(request: URLRequest) {
        
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(InstagramIDs.kInstaRedirectURI) {
            let range: Range<String.Index> = requestURLString.range(of: InstagramIDs.kInstaRange)!
            handleAuth(authToken: String(requestURLString[range.upperBound...]))
        }
    }
    
    /**
     handleAuth function is used to get user's Authentication token.
     
     - Parameter authToken: user authentication token
     - Returns: nil
    */
    func handleAuth(authToken: String)  {
        SVProgressHUD.dismiss()
        print("Instagram authentication token ==", authToken)
        saveStringToDefaults(string: authToken, key: .userAuthToken)
        guard let objHome = GetViewController(StoryBoard: .Home, Identifier: .Home) else {
            return
        }
        self.navigationController?.pushViewController(objHome, animated: true)
    }
}

//MARK:- WKNavigation Delegate
extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let urlString = navigationAction.request.url!.absoluteString
        
        guard let range = urlString.range(of: InstagramIDs.kInstaRange) else {
            decisionHandler(.allow)
            if urlString.contains(InstagramIDs.kInstaDenied) {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        
        decisionHandler(.cancel)
        handleAuth(authToken: (String(urlString[range.upperBound...])))
        DispatchQueue.main.async {
            self.success?(String(urlString[range.upperBound...]))
        }
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let httpResponse = navigationResponse.response as? HTTPURLResponse else {
            decisionHandler(.allow)
            return
        }
        
        switch httpResponse.statusCode {
        case 400:
            SVProgressHUD.dismiss()
            decisionHandler(.cancel)
            self.showAlert(strTitle: alerts.error, strMsg: alerts.somethingWrong)
        default:
            decisionHandler(.allow)
        }
    }
}
