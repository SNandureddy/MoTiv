//
//  UserDataModel.swift
//  MoTiv
//
//  Created by IOS on 26/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation
import UIKit

struct Organiser {
    var image: UIImage?
    var name: String!
    var userName: String!
    var email: String!
    var phone: String!
    var password: String!
    var confirmPassword: String?
    var about: String!
}


extension UserVM {
    
    func parseLoginData(response: JSONDictionary) {
        if let data = response[APIKeys.kData] as? JSONDictionary {
            DataManager.accessToken = data[APIKeys.kAccessToken] as? String
            let role = data[APIKeys.kRole] as? Int ?? 2
            DataManager.role = role
            let userId = data[APIKeys.kId] as? Int ?? 0
            DataManager.userId = userId
            BaseVC.userType = role == 3 ? .organiser: .user
            DataManager.isLoggedIn = true
            let userMusicInterests = data[APIKeys.kMusicInterest] as? String
            if userMusicInterests != "" {
                DataManager.userMusicInterests = userMusicInterests?.components(separatedBy: ",") ?? [String]()
            }
            let userPublicInterests = data[APIKeys.kPublicInterest] as? String
            if userPublicInterests != "" {
                DataManager.userPublicInterests = userPublicInterests?.components(separatedBy: ",") ?? [String]()
            }
        }
    }
}

extension LoginVC {
    
    /* ["picture": {
     data =     {
     height = 200;
     "is_silhouette" = 0;
     url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=2088125031&height=200&width=200&ext=15365024&hash=AeSe70wR21Xw";
     width = 200;
     };
     }, "name": User Name, "email": user@gmail.com, "id": 208814565646211739]*/
    func parseFBData(response: JSONDictionary) -> JSONDictionary {
        var dict = JSONDictionary()
        var url = String()
        if let imageData = response[APIKeys.kPicture] as? JSONDictionary {
            if let data = imageData[APIKeys.kData] as? JSONDictionary {
                url = data[APIKeys.kURL] as? String ?? ""
            }
        }
        dict[APIKeys.kImage] = URL(string: url)
        dict[APIKeys.kName] = response[APIKeys.kName] as? String ?? ""
        dict[APIKeys.kEmail] = response[APIKeys.kEmail] as? String ?? ""
        dict[APIKeys.kId] = response[APIKeys.kId] as! String
        dict[APIKeys.kSocialSignupType] = kFacebook
        return dict
    }
}
