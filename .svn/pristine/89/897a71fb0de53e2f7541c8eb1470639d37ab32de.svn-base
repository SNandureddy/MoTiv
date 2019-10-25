//
//  UserVM.swift
//  MoTiv
//
//  Created by IOS on 12/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

class UserVM {
    public static let shared = UserVM()
    private init() {}
    
    func login(email: String, password: String, response: @escaping responseCallBack) {
        APIManager.login(email: email, password: password, successCallback: { (responseDict) in
            self.parseLoginData(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func socialLogin(id: String, type: String, response: @escaping responseCallBack) {
        APIManager.socialLogin(id: id, type: type, successCallback: { (responseDict) in
            self.parseLoginData(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func signup(userDetails: JSONDictionary, imageDict: [String: Data]?, response: @escaping responseCallBack) {
        APIManager.signup(userDetails: userDetails, imageDict: imageDict, successCallback: { (responseDict) in
            self.parseLoginData(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func forgotPassword(email: String, response: @escaping responseCallBack) {
        APIManager.forgotPassword(email: email, successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func validateEmail(email: String, response: @escaping responseCallBack) {
        APIManager.validateEmail(email: email, successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
}
