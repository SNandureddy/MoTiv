//
//  CommonVM.swift
//  MoTiv
//
//  Created by IOS on 14/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

class CommonVM {
    public static let shared = CommonVM()
    private init() {}
    
    var musicArray = [Interest]()
    var publicArray = [Interest]()
    
    func getPublicInterest(response: @escaping responseCallBack) {
        APIManager.getPublicInterest(successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            self.parseCategoryData(response: responseDict, type: kPublic)
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getMusicInterest(response: @escaping responseCallBack) {
        APIManager.getMusicInterest(successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            self.parseCategoryData(response: responseDict, type: kMusic)
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }    
}
