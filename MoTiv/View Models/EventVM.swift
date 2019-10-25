//
//  EventVM.swift
//  MoTiv
//
//  Created by IOS on 18/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation

class EventVM {
    public static let shared = EventVM()
    private init() {}
    
    
    //MARK: Arrays
    var eventDetailArray: [EventDetail]?
    var guestListArray: [GuestList]?
    var postListArray: [PostList]?
    var commentListArray: [CommentList]?
    var ticketListArray: [TicketList]?
    var categoryEventDictionary = [String: [SearchEventDetail]]()
    var checkInUserDetailArray : [CheckInDetail]?
    var checkInGuestListArray : [CheckInDetail]?
    var guestDetailsArray : [CheckInGuestDetail]?
    var checkInEventDetailArray: [CheckInEventList]?
    var dashboardTicketsArray : [DashboardTicketsDetail]?
    var dashboardRecordsArray : [DashboardRecordsDetail]?

    //MARK: Variables
    var total : Int?
    var to : Int?
    var eventLastPage : Int?
    var postLastPage : Int?
    var guestListID : Int?
    var totalCheckIns : Int?
    var totalRevenue : Int?
    var grossSales : Int?
    var totalTickets : Int?
    var totalBoughtTickets : Int?

    // MARK: API Calls
    func createEvent(dict: JSONDictionary, imageDict: [String: Data], response: @escaping responseCallBack) {
        APIManager.createEvent(dict: dict, imageDict: imageDict, successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getEventList(dict: JSONDictionary, page: Int, response: @escaping responseCallBack){
        APIManager.getEventList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseEventList(response: responseDict, page: page)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
              response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getGuestList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getGuestList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseGuestList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getPostList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getPostList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parsePostList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getCommentList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getCommentList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseCommentList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getTicketList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getTicketList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseTicketList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func likePost(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.likePost(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func createPost(dict: JSONDictionary, imageDict: [String: Data], response: @escaping responseCallBack){
        APIManager.createPost(dict: dict, imageDict: imageDict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func addComment(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.addComment(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func addToFavourite(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.addToFavourite(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getSearchEventList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getSearchEventList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseSearchEventList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func addGuestList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.addGuestList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseAddGuest(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func addGuest(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.addGuest(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getCheckInDetails(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getCheckInDetails(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseCheckInDetails(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func getGuestsFromList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getGuestsFromList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseGuestDetailsFromList(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }

    func getCheckInEventList(dict: JSONDictionary, page: Int, response: @escaping responseCallBack){
        APIManager.getCheckInEventList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parseCheckInEventList(response: responseDict, page: page)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func bookTicket(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.bookTicket(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func closeSale(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.closeSale(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func deleteGuestsFromList(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.deleteGuestsFromList(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func getDashboardData(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.getDashboardData(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            self.parsedashboardData(response: responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func updateEvent(dict: JSONDictionary, imageDict: [String: Data], response: @escaping responseCallBack) {
        APIManager.updateEvent(dict: dict, imageDict: imageDict, successCallback: { (responseDict) in
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    func scanTicket(dict: JSONDictionary, response: @escaping responseCallBack){
        APIManager.scanTicket(dict: dict, successCallback: { (responseDict) in
            print(responseDict)
            let message = responseDict[APIKeys.kMessage] as? String ?? APIManager.OTHER_ERROR
            response(message, nil)
        }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
}
