//
//  APIService+Event.swift
//  MoTiv
//
//  Created by IOS on 18/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

enum EventAPIServices: APIService {
    
    case createEvent(dict: JSONDictionary)
    case getEventList(dict: JSONDictionary)
    case getGuestList(dict: JSONDictionary)
    case getPostList(dict: JSONDictionary)
    case getCommentList(dict: JSONDictionary)
    case getTicketList(dict: JSONDictionary)
    case likePost(dict: JSONDictionary)
    case createPost(dict: JSONDictionary)
    case addComment(dict: JSONDictionary)
    case addToFavourite(dict: JSONDictionary)
    case getSearchEventList(dict: JSONDictionary)
    case addGuestList(dict: JSONDictionary)
    case addGuest(dict: JSONDictionary)
    case getCheckInDetails(dict: JSONDictionary)
    case getGuestsFromList(dict: JSONDictionary)
    case getCheckInEventList(dict: JSONDictionary)
    case bookTicket(dict: JSONDictionary)
    case closeSale(dict: JSONDictionary)
    case deleteGuestsFromList(dict: JSONDictionary)
    case getDashboardData(dict: JSONDictionary)
    case updateEvent(dict: JSONDictionary)
    case scanTicket(dict: JSONDictionary)

    var path: String {
        var path = ""
        switch self {
        case .createEvent:
            path = BASE_URL.appending("createEvent")
        case .getEventList:
            path = BASE_URL.appending("event_list")
        case .getGuestList:
            path = BASE_URL.appending("guest_list")
        case .getPostList:
            path = BASE_URL.appending("post_list")
        case .getCommentList:
            path = BASE_URL.appending("comment_list")
        case .getTicketList:
            path = BASE_URL.appending("get_ticket_list")
        case .likePost:
            path = BASE_URL.appending("like_post")
        case .createPost:
            path = BASE_URL.appending("createPost")
        case .addComment:
            path = BASE_URL.appending("add_comment")
        case .addToFavourite:
            path = BASE_URL.appending("add_favourite")
        case .getSearchEventList:
            path = BASE_URL.appending("search_event")
        case .addGuestList:
            path = BASE_URL.appending("create_guest_list_name")
        case .addGuest:
            path = BASE_URL.appending("add_guest")
        case .getCheckInDetails:
            path = BASE_URL.appending("check_ins")
        case .getGuestsFromList:
            path = BASE_URL.appending("get_guest_list_name")
        case .getCheckInEventList:
            path = BASE_URL.appending("check_in_events")
        case .bookTicket:
            path = BASE_URL.appending("buy_ticket")
        case .closeSale:
            path = BASE_URL.appending("close_sale")
        case .deleteGuestsFromList:
            path = BASE_URL.appending("delete_guest")
        case .getDashboardData:
            path = BASE_URL.appending("dashboard")
        case .updateEvent:
            path = BASE_URL.appending("edit_event")
        case .scanTicket:
            path = BASE_URL.appending("scan_ticket")
        }
        return path
    }
    
    var resource: Resource {
        let header = [APIKeys.kAuthorization: "Bearer \(DataManager.accessToken ?? "")"]
        var resource: Resource!
        switch self {
        case let .createEvent(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getEventList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getGuestList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getPostList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getCommentList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getTicketList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .likePost(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .createPost(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .addComment(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .addToFavourite(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getSearchEventList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .addGuestList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .addGuest(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getCheckInDetails(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getGuestsFromList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getCheckInEventList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .bookTicket(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .closeSale(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .deleteGuestsFromList(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .getDashboardData(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .updateEvent(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        case let .scanTicket(dict):
            resource = Resource(method: .post, parameters: dict, headers: header)
        }
        return resource
    }
}

// MARK: Method for webservice
extension APIManager {
    
    class func createEvent(dict: JSONDictionary, imageDict: [String: Data], successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback) {
        EventAPIServices.createEvent(dict: dict).request(imageDict: imageDict, success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }
            else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getEventList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getEventList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getGuestList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getGuestList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getPostList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getPostList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getCommentList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getCommentList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getTicketList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getTicketList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func likePost(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.likePost(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func createPost(dict: JSONDictionary, imageDict: [String: Data], successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.createPost(dict: dict).request(imageDict: imageDict, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func addComment(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.addComment(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func addToFavourite(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.addToFavourite(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getSearchEventList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getSearchEventList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func addGuestList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.addGuestList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func addGuest(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.addGuest(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getCheckInDetails(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getCheckInDetails(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getGuestsFromList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getGuestsFromList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func getCheckInEventList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getCheckInEventList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    
    class func bookTicket(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.bookTicket(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    class func closeSale(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.closeSale(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    class func deleteGuestsFromList(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.deleteGuestsFromList(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    class func getDashboardData(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.getDashboardData(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    class func updateEvent(dict: JSONDictionary, imageDict: [String: Data], successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.updateEvent(dict: dict).request(imageDict: imageDict, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
    class func scanTicket(dict: JSONDictionary, successCallback : @escaping JSONDictionaryResponseCallback, failureCallback : @escaping APIServiceFailureCallback ){
        EventAPIServices.scanTicket(dict: dict).request(isJsonRequest: true, success: { (response) in
            if let responsedict = response as? JSONDictionary{
                successCallback(responsedict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallback)
    }
}