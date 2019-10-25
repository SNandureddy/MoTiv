//
//  EventDataModel.swift
//  MoTiv
//
//  Created by Apple on 01/02/19.
//  Copyright © 2019 MoTiv. All rights reserved.
//

import Foundation
import UIKit

struct EventDetail {
    var eventName: String?
    var ticketAmount: Int?
    var eventImageURL: String?
    var eventVideoURL: String?
    var eventImageURL2: String?
    var eventVideoURL2: String?
    var eventThemeURL: String?
    var eventDate: String?
    var eventDateTime: String?
    var eventEndDateTime: String?
    var guestCount: Int?
    var eventLocation: String?
    var eventDescription: String?
    var eventLatitude: Double?                     
    var eventLongitude: Double?
    var ticketCount: Int?
    var eventID: Int?
    var musicCategories = [Interest]()
    var publicCategories = [Interest]()
    var categories: [Interest]?
    var eventType: Int?
    var favouriteStatus: Int?
    var eventViews: Int?
    var repeatInterval: String?
    var contactNumber: String?
    var dressCode: String?
    var idRequired: String?
    var ageRestrictions: Int?
    var userId: Int?
    
    init(details: JSONDictionary) {
        self.eventName = details[APIKeys.kEventName] as? String
        self.ticketAmount = details[APIKeys.kTicketPrice] as? Int
        self.eventImageURL = details[APIKeys.kEventImageURL] as? String
        self.eventVideoURL = details[APIKeys.kEventVideoURL] as? String
        self.eventImageURL2 = details[APIKeys.kEventImageURL2] as? String
        self.eventVideoURL2 = details[APIKeys.kEventVideoURL2] as? String
        self.eventThemeURL = details[APIKeys.kEventThemeURL] as? String
        self.eventDate = details[APIKeys.kEventDate2] as? String
        self.eventDateTime = details[APIKeys.kEventStartDate] as? String
        self.eventEndDateTime = details[APIKeys.kEventEndDate] as? String
        self.guestCount = details[APIKeys.kGuestCount] as? Int
        self.eventLocation = details[APIKeys.kEventLocation] as? String
        self.eventDescription = details[APIKeys.kDescription] as? String
        self.repeatInterval = details[APIKeys.kRepeatInterval] as? String
        self.contactNumber = details[APIKeys.kContactNumber] as? String
        self.dressCode = details[APIKeys.kDressCode] as? String
        self.idRequired = details[APIKeys.kIdRequired] as? String
        self.eventLatitude = details[APIKeys.kEventLat] as? Double
        self.eventLongitude = details[APIKeys.kEventLong] as? Double
        self.ticketCount = details[APIKeys.kTicketAvailableCount] as? Int
        self.eventID = details[APIKeys.kId] as? Int
        self.eventType = details[APIKeys.kSubmitBy] as? Int
        self.eventViews = details[APIKeys.kEventViews] as? Int
        self.favouriteStatus = details[APIKeys.kFavouriteStatus] as? Int
        self.ageRestrictions = details[APIKeys.kAgeRestrictions] as? Int
        self.userId = details[APIKeys.kUserId] as? Int

        var musicCategoryArray = [Interest]()
        if let musicArray = details[APIKeys.kMusicInterestID] as? JSONArray {
            for category in musicArray {
                let id = category[APIKeys.kId] as! Int
                let name = category[APIKeys.kName] as? String ?? ""
                let imagePath = category[APIKeys.kImage] as? String ?? ""
                let image = "\(IMAGE_URL)\(imagePath)".replacingOccurrences(of: " ", with: "%20")
                musicCategoryArray.append(Interest(id: id, name: name, image: URL(string: image)))
            }
        }
        var publicCategoryArray = [Interest]()
        if let publicArray = details[APIKeys.kPublicInterestID] as? JSONArray {
            for category in publicArray {
                let id = category[APIKeys.kId] as! Int
                let name = category[APIKeys.kName] as? String ?? ""
                let imagePath = category[APIKeys.kImage] as? String ?? ""
                let image = "\(IMAGE_URL)\(imagePath)".replacingOccurrences(of: " ", with: "%20")
                publicCategoryArray.append(Interest(id: id, name: name, image: URL(string: image)))
            }
        }
        self.musicCategories = musicCategoryArray
        self.publicCategories = publicCategoryArray
        self.categories = self.musicCategories + self.publicCategories
    }
}

struct GuestList {
    var guestName : String?
    var guestImageURL : String?
    
    init(details: JSONDictionary) {
        self.guestName = details[APIKeys.kName] as? String
        self.guestImageURL = details[APIKeys.kImageURL] as? String
    }
}

struct PostList {
    var postImageURL : String?
    var postText : String?
    var commentCount : Int?
    var likeCount : Int?
    var postID : Int?
    var postLikeStatus : Int?
    
    init(details: JSONDictionary) {
        self.postImageURL = details[APIKeys.kPostImageURL] as? String
        self.postText = details[APIKeys.kText] as? String
        self.commentCount = details[APIKeys.kCommentCount] as? Int
        self.likeCount = details[APIKeys.kLikeCount] as? Int
        self.postID = details[APIKeys.kId] as? Int
        self.postLikeStatus = details[APIKeys.kLikeStatus] as? Int
    }
}

struct CommentList {
    var comment : String?
    var imageURL : String?
    init(details: JSONDictionary) {
        self.comment = details[APIKeys.kComment] as? String
        if let userInfoDict = details[APIKeys.kUserInfo] as? JSONDictionary {
            self.imageURL = userInfoDict[APIKeys.kImageURL] as? String
        }
    }
}

struct TicketList {
    var ticketTitle : String?
    var ticketDescription : String?
    var ticketAmount : Int?
    var ticketId : Int?
    var ticketQuantity : Int?
    var ticketCount : Int?
    var ticketPrice : Double?
    var remainingTickets : Int?
    var subtotal : Double?

    init(details: JSONDictionary) {
        self.ticketTitle = details[APIKeys.kTicketTitle] as? String
        self.ticketDescription = details[APIKeys.kTicketDescription] as? String
        self.ticketAmount = details[APIKeys.kTicketAmount] as? Int
        self.ticketQuantity = details[APIKeys.kTicketQuantity] as? Int
        self.remainingTickets = details[APIKeys.kRemainingTickets] as? Int
        self.ticketId = details[APIKeys.kId] as? Int
        self.ticketCount = 0
        self.ticketPrice = 0.0
    }
}

struct SearchEventDetail {
    var eventName : String?
    var eventImageURL : String?
    var eventTicketPrice : Int?
    var eventMusicInterestID : [String]?
    var eventPublicInterestID : [String]?
    var eventVideoURL : String?
    var eventDate : String?
    var eventDateTime: String?
    var guestCount: Int?
    var eventLocation: String?
    var eventDescription: String?
    var eventLatitude: Double?
    var eventLongitude: Double?
    var ticketCount: Int?
    var eventID: Int?
    var eventType: Int?
    var eventViews: Int?
    var userId: Int?

    init(details: JSONDictionary) {
        self.eventName = details[APIKeys.kEventName] as? String
        self.eventImageURL = details[APIKeys.kEventImageURL] as? String
        self.eventVideoURL = details[APIKeys.kEventVideoURL] as? String
        self.eventTicketPrice = details[APIKeys.kTicketPrice] as? Int
        self.eventDate = details[APIKeys.kEventDate2] as? String
        self.eventDateTime = details[APIKeys.kEventStartDate] as? String
        self.guestCount = details[APIKeys.kGuestCount] as? Int
        self.eventLocation = details[APIKeys.kEventLocation] as? String
        self.eventDescription = details[APIKeys.kDescription] as? String
        self.eventLatitude = details[APIKeys.kEventLat] as? Double
        self.eventLongitude = details[APIKeys.kEventLong] as? Double
        self.ticketCount = details[APIKeys.kTicketAvailableCount] as? Int
        self.eventID = details[APIKeys.kId] as? Int
        self.eventType = details[APIKeys.kSubmitBy] as? Int
        self.eventViews = details[APIKeys.kEventViews] as? Int
        self.userId = details[APIKeys.kUserId] as? Int
        let eventMusicID = details[APIKeys.kMusicIntID] as? String
        if eventMusicID != "" {
            self.eventMusicInterestID = eventMusicID?.components(separatedBy: ",") ?? [String]()
        }
        let eventPublicID = details[APIKeys.kPublicIntID] as? String
        if eventPublicID != "" {
            self.eventPublicInterestID = eventPublicID?.components(separatedBy: ",") ?? [String]()
        }
    }
}

struct CheckInDetail {
    var userName : String?
    var ticketName : String?
    var guestListName : String?
    var guestListNameID : Int?
    
    init(details: JSONDictionary) {
        self.userName = details[APIKeys.kUserName] as? String
        self.ticketName = details[APIKeys.kTicketTitle] as? String
        self.guestListName = details[APIKeys.kGuestListName] as? String
        self.guestListNameID = details[APIKeys.kId] as? Int
    }
}

struct CheckInGuestDetail {
    var guestName : String?
    var guestID : Int?
    
    init(details: JSONDictionary) {
        self.guestName = details[APIKeys.kFullName] as? String
        self.guestID = details[APIKeys.kId] as? Int
    }
}

struct CheckInEventList {
    var eventName : String?
    var ticketSoldCount : Int?
    var guestCount: Int?
    var eventDate : String?
    var eventDateTime: String?
    var eventID: Int?
    var eventImageURL : String?
    var eventVideoURL : String?
    var eventViews : Int?
    
    init(details: JSONDictionary) {
        self.eventName = details[APIKeys.kEventName] as? String
        self.ticketSoldCount = details[APIKeys.kTicketSoldCount] as? Int
        self.eventImageURL = details[APIKeys.kEventImageURL] as? String
        self.eventVideoURL = details[APIKeys.kEventVideoURL] as? String
        self.eventDate = details[APIKeys.kEventDate2] as? String
        self.eventDateTime = details[APIKeys.kEventStartDate] as? String
        self.guestCount = details[APIKeys.kGuestCount] as? Int
        self.eventID = details[APIKeys.kId] as? Int
        self.eventViews = details[APIKeys.kEventViews] as? Int
    }
}

struct DashboardTicketsDetail {
    var ticketTitle : String?
    var ticketId : Int?
    var ticketQuantity : Int?
    var boughtTickets : Int?
    
    init(details: JSONDictionary) {
        self.ticketTitle = details[APIKeys.kTicketTitle] as? String
        self.ticketId = details[APIKeys.kId] as? Int
        self.ticketQuantity = details[APIKeys.kTicketQuantity] as? Int
        self.boughtTickets = details[APIKeys.kBoughtTickets] as? Int
    }
}

struct DashboardRecordsDetail {
    var dateTime : Date?
    var tickets : Int?
    var hour : Int?
    var bought : Int?
    
    init(details: JSONDictionary) {
        self.dateTime = details[APIKeys.kDateTime] as? Date
        self.tickets = details[APIKeys.kSmallTickets] as? Int
        self.hour = details[APIKeys.kHour] as? Int
        self.bought = details[APIKeys.kBought] as? Int
    }
}


//MARK: Parsing data
extension EventVM {
    func parseEventList(response: JSONDictionary, page: Int) {
        if page == 1 {
            self.eventDetailArray = [EventDetail]()
        }
        if let data = response[APIKeys.kData] as? JSONDictionary{
            self.eventLastPage = data[APIKeys.kLastPage] as? Int
            self.total = data[APIKeys.kTotal] as? Int
            self.to = data[APIKeys.kTo] as? Int
            if let eventDataArray = data[APIKeys.kData] as? JSONArray {
                for event in eventDataArray {
                    let eventList = EventDetail(details: event)
                    self.eventDetailArray?.append(eventList)
                }
            }
        }
    }
    
    func parseGuestList(response: JSONDictionary) {
        self.guestListArray = [GuestList]()
        if let data = response[APIKeys.kData] as? JSONDictionary{
            if let guestDataArray = data[APIKeys.kData] as? JSONArray {
                for guest in guestDataArray {
                    let guestList = GuestList(details: guest)
                    self.guestListArray?.append(guestList)
                }
            }
        }
    }

    func parsePostList(response: JSONDictionary) {
        self.postListArray = [PostList]()
        if let data = response[APIKeys.kData] as? JSONDictionary{
            self.postLastPage = data[APIKeys.kLastPage] as? Int
            self.total = data[APIKeys.kTotal] as? Int
            self.to = data[APIKeys.kTo] as? Int
            if let postDataArray = data[APIKeys.kData] as? JSONArray {
                for post in postDataArray {
                    let postList = PostList(details: post)
                    self.postListArray?.append(postList)
                }
            }
        }
    }
    
    func parseCommentList(response: JSONDictionary) {
        self.commentListArray = [CommentList]()
        if let data = response[APIKeys.kData] as? JSONArray {
                for comment in data {
                    let commentList = CommentList(details: comment)
                    self.commentListArray?.append(commentList)
            }
        }
    }
    
    func parseTicketList(response: JSONDictionary) {
        self.ticketListArray = [TicketList]()
        if let data = response[APIKeys.kData] as? JSONArray {
            for ticket in data {
                let ticketList = TicketList(details: ticket)
                self.ticketListArray?.append(ticketList)
            }
        }
    }
    
    func parseSearchEventList(response: JSONDictionary) {
        categoryEventDictionary = [String: [SearchEventDetail]]()
        if let searchEventDataArray = response[APIKeys.kData] as? JSONArray {
            for event in searchEventDataArray {
                let eventList = SearchEventDetail(details: event)
                if eventList.eventPublicInterestID != nil {
                    for publicCategory in eventList.eventPublicInterestID! {
                        let categoryName = getCategoryName(type: kPublic, id: Int(publicCategory) ?? 0)
                        if var categoryArray: [SearchEventDetail] = categoryEventDictionary[categoryName] {
                            categoryArray.append(eventList)
                            categoryEventDictionary[categoryName] = categoryArray
                        }
                        else {
                            categoryEventDictionary[categoryName] = [eventList]
                        }
                    }
                }
                if eventList.eventMusicInterestID != nil {
                    for musicCategory in eventList.eventMusicInterestID ?? [String]() {
                        let categoryName = getCategoryName(type: kMusic, id: Int(musicCategory) ?? 0)
                        if var categoryArray: [SearchEventDetail] = categoryEventDictionary[categoryName] {
                            categoryArray.append(eventList)
                            categoryEventDictionary[categoryName] = categoryArray
                        }
                        else {
                            categoryEventDictionary[categoryName] = [eventList]
                        }
                    }
                }
            }
        }
    }
    
    private func getCategoryName(type: String, id: Int) -> String {
        if type == kMusic {
            if let index = CommonVM.shared.musicArray.firstIndex(where: {$0.id == id}) {
                return CommonVM.shared.musicArray[index].name ?? ""
            }
        }
        else {
            if let index = CommonVM.shared.publicArray.firstIndex(where: {$0.id == id}) {
                return CommonVM.shared.publicArray[index].name ?? ""
            }
        }
        return  ""
    }

    
    func parseAddGuest(response: JSONDictionary) {
        if let data = response[APIKeys.kData] as? Int {
            self.guestListID = data
        }
    }
    
    func parseCheckInDetails(response: JSONDictionary) {
        self.checkInUserDetailArray = [CheckInDetail]()
        self.checkInGuestListArray = [CheckInDetail]()
        if let data = response[APIKeys.kData] as? JSONDictionary{
            if let totalCheckIns = data[APIKeys.kTotalCheckIns] as? Int {
                self.totalCheckIns = totalCheckIns
            }
            if let totalRevenue = data[APIKeys.kTotalRevenue] as? Int {
                self.totalRevenue = totalRevenue
            }
            if let checkInUserDetailArray = data[APIKeys.kCheckInUsers] as? JSONArray {
                for data in checkInUserDetailArray {
                    let checkInUserList = CheckInDetail(details: data)
                    self.checkInUserDetailArray?.append(checkInUserList)
                }
            }
            if let checkInGuestDetailArray = data[APIKeys.kGuestList] as? JSONArray {
                for data in checkInGuestDetailArray {
                    let checkInGuestList = CheckInDetail(details: data)
                    self.checkInGuestListArray?.append(checkInGuestList)
                }
            }
        }
    }
    
    func parseGuestDetailsFromList(response: JSONDictionary) {
        self.guestDetailsArray = [CheckInGuestDetail]()
        if let data = response[APIKeys.kData] as? JSONArray {
            for detail in data {
                let guestDetailList = CheckInGuestDetail(details: detail)
                self.guestDetailsArray?.append(guestDetailList)
            }
        }
    }
    
    func parseCheckInEventList(response: JSONDictionary, page: Int) {
        if page == 1 {
            self.checkInEventDetailArray = [CheckInEventList]()
        }
        if let data = response[APIKeys.kData] as? JSONDictionary{
            self.eventLastPage = data[APIKeys.kLastPage] as? Int
            self.total = data[APIKeys.kTotal] as? Int
            self.to = data[APIKeys.kTo] as? Int
            if let checkInEventDataArray = data[APIKeys.kData] as? JSONArray {
                for event in checkInEventDataArray {
                    let eventList = CheckInEventList(details: event)
                    self.checkInEventDetailArray?.append(eventList)
                }
            }
        }
    }
    
    func parsedashboardData(response: JSONDictionary) {
        self.dashboardTicketsArray = [DashboardTicketsDetail]()
        self.dashboardRecordsArray = [DashboardRecordsDetail]()
        if let data = response[APIKeys.kData] as? JSONDictionary{
            if let grossSales = data[APIKeys.kGrossSales] as? Int {
                self.grossSales = grossSales
            }
            if let totalTickets = data[APIKeys.kTotalTickets] as? Int {
                self.totalTickets = totalTickets
            }
            if let totalBoughtTickets = data[APIKeys.kTotalBoughtTickets] as? Int {
                self.totalBoughtTickets = totalBoughtTickets
            }
            if let dashboardTicketArray = data[APIKeys.kTicketsList] as? JSONArray {
                for ticket in dashboardTicketArray {
                    let ticketsDetail = DashboardTicketsDetail(details: ticket)
                    self.dashboardTicketsArray?.append(ticketsDetail)
                }
            }
            if let dashboardRecordArray = data[APIKeys.kRecord] as? JSONArray {
                for record in dashboardRecordArray {
                    let recordDetail = DashboardRecordsDetail(details: record)
                    self.dashboardRecordsArray?.append(recordDetail)
                }
            }
        }
    }
}


