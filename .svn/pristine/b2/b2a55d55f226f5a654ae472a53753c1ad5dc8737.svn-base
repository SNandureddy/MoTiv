//
//  TwitterLoginSuite.swift
//  MoTiv
//
//  Created by IOS on 12/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation
import TwitterKit

//MARK: **** KEYS ****
let TW_KEY = "9fpN3qcVMcjBI26OOA10DRBCs"
let TW_SECRET = "PKtWyfEkxOjRQ12cUyPyOHyAa9NX9tiMNGfMlCAZs58nzPvdD3"


struct TwUser {
    var name: String!
    var email: String!
    var id: String!
    var profileImage: URL?
    
    var jsonDict: JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kName] = name!
        dict[APIKeys.kEmail] = email!
        dict[APIKeys.kId] = id
        dict[APIKeys.kImage] = profileImage
        dict[APIKeys.kSocialSignupType] = kTwitter
        return dict
    }

    
    init(details: JSONDictionary) {
        self.name = details[APIKeys.kName] as? String ?? ""
        self.email = details[APIKeys.kEmail] as? String ?? ""
        self.id = details[APIKeys.kId] as? String ?? ""
        self.profileImage = URL(string: details[APIKeys.kImage] as? String ?? "")
    }
}

typealias twitterResponse = ((TwUser?, Error?) -> ())

class TwitterLoginSuite {
    
    static var shared = TwitterLoginSuite()
    private var details = JSONDictionary()
    
    //MARK: Login
    func login(response: @escaping twitterResponse){
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if let session = session {
                self.details[APIKeys.kName]  = session.userName
                self.details[APIKeys.kId] = session.userID
                self.getEmail(email: { (email) in
                    self.details[APIKeys.kEmail] = email
                    self.getImage(id: session.userID, image: { (imageURL) in
                        self.details[APIKeys.kImage] = imageURL
                        let userDetails = TwUser(details: self.details)
                        response(userDetails, nil)
                    })
                })
            }
        }
    }
    
    private func getEmail(email: @escaping ((String?) -> ())) {
        TWTRAPIClient.withCurrentUser().requestEmail { (mail, error) in
            if let mail = mail {
                email(mail)
            }
        }
    }
    
    private func getImage(id: String, image: @escaping ((String) -> ())) {
        TWTRAPIClient.withCurrentUser().loadUser(withID: id) { (user, error) in
            if let user  = user {
                image(user.profileImageURL)
            }
        }
    }
}
