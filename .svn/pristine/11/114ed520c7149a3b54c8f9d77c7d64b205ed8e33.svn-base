//
//  CommonDataModel.swift
//  MoTiv
//
//  Created by IOS on 14/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

struct Interest {
    var id: Int!
    var name: String!
    var image: URL?
}

extension CommonVM {
    
    func parseCategoryData(response: JSONDictionary, type: String) {
        if type == kPublic {
            publicArray.removeAll()
        }
        else {
            musicArray.removeAll()
        }
        if let dataArray = response[APIKeys.kData] as? JSONArray {
            for data in dataArray {
                let id = data[APIKeys.kId] as! Int
                let name = data[APIKeys.kName] as! String
                let image = URL(string: "\(IMAGE_URL)\((data[APIKeys.kImage] as! String))".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
                let details = Interest(id: id, name: name.uppercased(), image: image)
                if type == kPublic {
                    publicArray.append(details)
                }
                else {
                    musicArray.append(details)
                }
            }
        }
    }
}
