//
//  APIServcie+Common.swift
//  MoTiv
//
//  Created by IOS on 14/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

enum CommonAPIServices: APIService {
    
    case getPublicInterest
    case getMusicInterest
    
    var path: String {
        var path = ""
        switch self {
        case .getMusicInterest:
            path = BASE_URL.appending("musicInterestList")
        case .getPublicInterest:
            path = BASE_URL.appending("publicInterestList")
        }
        return path
    }
    
    var resource: Resource {
        var resource: Resource!
        switch self {
        case .getMusicInterest:
            resource = Resource(method: .post, parameters: nil, headers: nil)
        case .getPublicInterest:
            resource = Resource(method: .post, parameters: nil, headers: nil)
        }
        return resource
    }
    
}

// MARK: Method for webservice
extension APIManager {
    
    class func getMusicInterest(successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        CommonAPIServices.getMusicInterest.request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getPublicInterest(successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        CommonAPIServices.getPublicInterest.request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
}
