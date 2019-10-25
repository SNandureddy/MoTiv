//
//  APIService+User.swift
//  Lens App
//
//  Created by Apple on 13/08/18.
//  Copyright © 2018 Deftsoft. All rights reserved.
//

import Foundation

enum UserAPIServices: APIService {
    
    case forgotPassword(email: String)
    case socailLogin(id: String, type: String)
    case signup(userDetails: JSONDictionary)
    case validateEmail(email: String)
    case login(email: String, password: String)
    
    var path: String {
        var path = ""
        switch self {
        case .socailLogin:
            path = BASE_URL.appending("socialLogin")
        case .forgotPassword:
            path = BASE_URL.appending("forgotPassword")
        case .signup:
            path = BASE_URL.appending("signup")
        case .validateEmail:
            path = BASE_URL.appending("checkEmailExist")
        case .login:
            path = BASE_URL.appending("signin")
        }
        return path
    }
    
    var resource: Resource {
        var resource: Resource!
        switch self {
            
        case let .socailLogin(id, type):
            resource = Resource(method: .post, parameters: [APIKeys.kSocialId: id, APIKeys.kSocialSignupType: type], headers: nil)
       
        case let .forgotPassword(email):
            resource = Resource(method: .post, parameters: [APIKeys.kEmail:email], headers: nil)
            
        case let .signup(userDetails):
            resource = Resource(method: .post, parameters: userDetails, headers: nil)
            
        case let .validateEmail(email):
            resource = Resource(method: .post, parameters: [APIKeys.kEmail:email], headers: nil)
            
        case let .login(email, password):
            resource = Resource(method: .post, parameters: [APIKeys.kEmail:email, APIKeys.kPassword: password], headers: nil)
        }
        return resource
    }
    
}

// MARK: Method for webservice
extension APIManager {
    
    class func socialLogin(id: String, type: String, successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        UserAPIServices.socailLogin(id: id, type: type).request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func forgotPassword(email: String, successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        UserAPIServices.forgotPassword(email: email).request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func signup(userDetails: JSONDictionary, imageDict: [String: Data]?, successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        UserAPIServices.signup(userDetails: userDetails).request(imageDict: imageDict, success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func validateEmail(email: String, successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        UserAPIServices.validateEmail(email: email).request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func login(email: String, password: String, successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        UserAPIServices.login(email: email, password: password).request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
}
