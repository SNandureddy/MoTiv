//
//  InstagramLoginSuite.swift
//  MoTiv
//
//  Created by IOS on 12/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation
import WebKit

struct InstaUser {
    var id: String!
    var name: String!
    var profileImage: URL?
    
    var jsonDict: JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kName] = name!
        dict[APIKeys.kId] = id
        dict[APIKeys.kImage] = profileImage
        dict[APIKeys.kSocialSignupType] = kInstagram
        return dict
    }
    init(details: JSONDictionary) {
        self.id = (details[APIKeys.kId] as! String)
        self.name = details[APIKeys.kName] as? String ?? ""
        self.profileImage =  URL(string: details[APIKeys.kImage] as? String ?? "")
    }
}

protocol InstaDelegate {
    func successWithLogin(user: InstaUser?)
}


class InstagramLoginSuite: NSObject {
    
    //MARK: APIKeys
    let kINSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    let kINSTAGRAM_APIURl  = "https://api.instagram.com/v1/users/"
    let kINSTAGRAM_CLIENT_ID  = "fb4fe71310484f2a994b5a5a76de1006"
    let kINSTAGRAM_CLIENTSERCRET = "08964b3e7f5b4ba9a7631d93cd75bdad"
    let kINSTAGRAM_REDIRECT_URI = "http://motivuk.com/app"
    let kINSTAGRAM_ACCESS_TOKEN =  "access_token"
    let kINSTAGRAM_SCOPE = "likes+comments+relationships"
    
    //MARK: Variables
    static var shared = InstagramLoginSuite()
    var delegate: InstaDelegate!
    private var webView: UIWebView!
    private var myToolbar: UIToolbar!
    private var details = JSONDictionary()

    //MARK: Login
    func login(baseView: UIView) {
        webView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webView.delegate = self
        baseView.addSubview(webView)
        createRequest()
    }
    
    //Private Methods
    private func setupToolbar(){
        myToolbar = UIToolbar(frame: CGRect(x: 0, y: self.webView.bounds.size.height - 44, width: self.webView.bounds.size.width, height: 40.0))
        myToolbar.layer.position = CGPoint(x: self.webView.bounds.width/2, y: self.webView.bounds.height-20.0)
        myToolbar.barStyle = .blackTranslucent
        myToolbar.tintColor = UIColor.white
        myToolbar.backgroundColor = UIColor.motivColor.instagramColor.color()
        let closeButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(onClickBarButton(sender:)))
        closeButton.tag = 1
        myToolbar.items = [closeButton]
        self.webView.addSubview(myToolbar)
    }
    
    //MARK: IBActions
    @objc internal func onClickBarButton(sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            webView.stopLoading()
            webView.removeFromSuperview()
            break
        default:
            break
        }
    }
    
}

//MARK: URL Requests
extension InstagramLoginSuite {
    
    func createRequest () {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [kINSTAGRAM_AUTHURL,kINSTAGRAM_CLIENT_ID,kINSTAGRAM_REDIRECT_URI,kINSTAGRAM_SCOPE ])
        debugPrint(URL.init(string: authURL) as Any)
        let urlRequest =  URLRequest.init(url:URL.init(string: authURL)! )
        webView.loadRequest(urlRequest)
        setupToolbar()
    }
    
    func checkRequest(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(kINSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken:requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    
    func handleAuth(authToken: String)  {
        print("Instagram authentication token ==", authToken)
        getUserData(token: authToken)
        self.webView.removeFromSuperview()
    }
    
    private func getUserData(token: String) {
        let  url = URL(string:("https://api.instagram.com/v1/users/self/?access_token=\(token)"))
        let session = URLSession.shared
        session.dataTask(with: url!) {(data, response, error) -> Void in
            if data != nil{
                let jsondata = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                print(jsondata!)
                if let userdata = jsondata!["data"]as? NSDictionary {
                    self.details[APIKeys.kId] = userdata[APIKeys.kId] as! String
                    self.details[APIKeys.kName] = userdata[APIKeys.kFullName] as? String
                    self.details[APIKeys.kImage] = userdata[APIKeys.kProfilePicture] as? String
                    let userDetails = InstaUser(details: self.details)
                    self.delegate.successWithLogin(user: userDetails)
                }
            }else { print(error ?? "got some error!")}
            }.resume()
    }
}

//MARK: Webview Delegates
extension InstagramLoginSuite:  UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequest(request: request)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    }
}
