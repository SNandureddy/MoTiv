//
//  EventDetailVC.swift
//  MoTiv
//
//  Created by IOS on 27/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

enum PreviousScreen {
    case main
    case invitation
    case past
    case ticket
    case search
    case checkin
}

import UIKit
import XLActionController
import SDWebImage
import AVKit
import EventKit

class EventDetailVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var attndingButton: UIButton!
    @IBOutlet weak var posButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var ticketLeftLabel: UILabel!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var viewPostIcon: UIImageView!
    
    //MARK: Variables
    var index = 0
    var selectedIndex = Int()
    var selectedTime : EventTime?
    var eventImage : UIImage?
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()
    var categoryInterestArray : [Interest]?
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .invitation {
            secondButton.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryInterestArray = [Interest]()
        self.customiseUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPopover(type: .down, title: kPlayPop, sender: playButton)
    }
    
    override func rightButtonAction(sender: UIButton) {
        if BaseVC.userType == .user {
            if sender.tag == 2 {
                let shareText = "Hi, I've created a new event \(EventVM.shared.eventDetailArray?[selectedIndex].eventName ?? "")"
                if let image = imageView.image {
                    let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: nil)
                    present(vc, animated: true, completion: nil)
                }
            } else {
                let invitevc = self.storyboard?.instantiateViewController(withIdentifier: "InviteFriendVC") as! InviteUserVC
                invitevc.type = .friends
                self.navigationController?.show(invitevc, sender: self)
            }
        } else {
            let updatevc = self.storyboard?.instantiateViewController(withIdentifier: kOCreateMainVC) as! O_CreateMainVC
            updatevc.isUpdate = true
            updatevc.selectedIndex = self.selectedIndex
            self.navigationController?.show(updatevc, sender: self)
        }
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: "", showBack: true)
        if selectedTime == .favourite {
            favouriteButton.isSelected = true
        }
        locationButton.set(radius: 14.0, borderColor: UIColor.motivColor.baseColor.color(), borderWidth: 1.0)
        attndingButton.set(radius: 14.0, borderColor: UIColor.motivColor.baseColor.color(), borderWidth: 1.0)
        posButton.set(radius: 14.0, borderColor: UIColor.motivColor.baseColor.color(), borderWidth: 1.0)
        scanButton.set(radius: 14.0)
        scanButton.setBackgroundImage(scanButton.graidentImage, for: .normal)
        
        if type == .main {
            if EventVM.shared.eventDetailArray?[selectedIndex].eventType == 3 {
//                scanButton.isHidden = ((EventVM.shared.eventDetailArray?[selectedIndex].userId ?? 0) == DataManager.userId) ? false : true
                priceLabel.isHidden = false
                self.ticketLeftLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].ticketCount == 1 ? ("HURRY, ONLY \(EventVM.shared.eventDetailArray?[selectedIndex].ticketCount ?? 0) TICKET LEFT") : ("HURRY, ONLY \(EventVM.shared.eventDetailArray?[selectedIndex].ticketCount ?? 0) TICKETS LEFT")
                ticketLeftLabel.isHidden = (EventVM.shared.eventDetailArray?[selectedIndex].ticketCount != 0 && (EventVM.shared.eventDetailArray?[selectedIndex].ticketCount ?? 0) <= 10) ? false : true
            }
            locationButton.setTitle(EventVM.shared.eventDetailArray?[selectedIndex].eventLocation, for: .normal)
            if EventVM.shared.eventDetailArray?[selectedIndex].eventType == 3 {
                attndingButton.setTitle("\(EventVM.shared.eventDetailArray?[selectedIndex].eventViews ?? 0) Views", for: .normal)
            } else {
                priceLabel.isHidden = true
                scanButton.isHidden = true
                attndingButton.setTitle("\(EventVM.shared.eventDetailArray?[selectedIndex].guestCount ?? 0) ATTENDING", for: .normal)
            }
            self.imageView.sd_setImage(with: URL(string: EventVM.shared.eventDetailArray?[selectedIndex].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            self.nameLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].eventName
            self.timeLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .time, type: .local)
            self.dateLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].eventDate
            self.descriptionLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].eventDescription
            self.priceLabel.text = "From \(Double(EventVM.shared.eventDetailArray?[selectedIndex].ticketAmount ?? 0).roundToTwoDecimal.amountValue)"
        } else if type == .invitation {
            secondButton.isHidden = false
            secondButton.set(radius: 14.0)
            secondButton.setBackgroundImage(scanButton.graidentImage, for: .normal)
            scanButton.setTitle("ACCEPT", for: .normal)
            secondButton.setTitle("REJECT", for: .normal)
            viewPostIcon.isHidden = true
            posButton.isHidden = true
            self.hideRightButton()
            ticketLeftLabel.isHidden = true
        } else if type == .past || type == .ticket {
            self.hideRightButton()
            secondButton.isHidden = true
            scanButton.isHidden = true
            ticketLeftLabel.isHidden = true
        } else {
            if categoryEventDetailArray[selectedIndex].eventType == 3 {
//                scanButton.isHidden = ((categoryEventDetailArray[selectedIndex].userId) == DataManager.userId) ? false : true
                priceLabel.isHidden = false
                self.ticketLeftLabel.text = categoryEventDetailArray[selectedIndex].ticketCount == 1 ? ("HURRY, ONLY \(categoryEventDetailArray[selectedIndex].ticketCount ?? 0) TICKET LEFT") : ("HURRY, ONLY \(categoryEventDetailArray[selectedIndex].ticketCount ?? 0) TICKETS LEFT")
                ticketLeftLabel.isHidden = (categoryEventDetailArray[selectedIndex].ticketCount != 0 && (categoryEventDetailArray[selectedIndex].ticketCount ?? 0) <= 10) ? false : true
            }
            locationButton.setTitle(categoryEventDetailArray[selectedIndex].eventLocation, for: .normal)
            if categoryEventDetailArray[selectedIndex].eventType == 3 {
                attndingButton.setTitle("\(categoryEventDetailArray[selectedIndex].eventViews ?? 0) Views", for: .normal)
            } else {
                scanButton.isHidden = true
                priceLabel.isHidden = true
                attndingButton.setTitle("\(categoryEventDetailArray[selectedIndex].guestCount ?? 0) ATTENDING", for: .normal)
            }
            self.imageView.sd_setImage(with: URL(string: categoryEventDetailArray[selectedIndex].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
            self.nameLabel.text = categoryEventDetailArray[selectedIndex].eventName
            self.timeLabel.text = categoryEventDetailArray[selectedIndex].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .time, type: .local)
            self.dateLabel.text = categoryEventDetailArray[selectedIndex].eventDate
            self.descriptionLabel.text = categoryEventDetailArray[selectedIndex].eventDescription
            self.priceLabel.text = "From \(Double(categoryEventDetailArray[selectedIndex].eventTicketPrice ?? 0).roundToTwoDecimal.amountValue)"
            self.handleCategories()
        }
        if BaseVC.userType == .organiser {
            if type == .main {
                scanButton.isHidden = ((EventVM.shared.eventDetailArray?[selectedIndex].userId ?? 0) == DataManager.userId) ? false : true
                if ((EventVM.shared.eventDetailArray?[selectedIndex].userId ?? 0) == DataManager.userId) {
                    setRightButton(image: #imageLiteral(resourceName: "editButton"))
                }
            }
            if type == .search {
                scanButton.isHidden = ((categoryEventDetailArray[selectedIndex].userId) == DataManager.userId) ? false : true
                if (categoryEventDetailArray[selectedIndex].userId == DataManager.userId) {
                    setRightButton(image: #imageLiteral(resourceName: "editButton"))
                }
            }
            ticketLeftLabel.isHidden = true
            favouriteButton.isHidden = true
        }
        else {
            favouriteButton.isSelected = EventVM.shared.eventDetailArray?[selectedIndex].favouriteStatus == 1 ? true : false
            setTwoRightButtons(image1: #imageLiteral(resourceName: "addChatUser"), image2: #imageLiteral(resourceName: "shareIconWhite"))
            scanButton.setTitle("BOOK NOW", for: .normal)
        }
    }
    
    private func handleCategories() {
        if let userPublicInterests = categoryEventDetailArray[selectedIndex].eventPublicInterestID {
            for interest in userPublicInterests {
                if let index = CommonVM.shared.publicArray.firstIndex(where: {$0.id == Int(interest)}) {
                    categoryInterestArray?.append( CommonVM.shared.publicArray[index])
                }
            }
        }
        if let userMusicInterests = categoryEventDetailArray[selectedIndex].eventMusicInterestID {
            for interest in userMusicInterests {
                if let index = CommonVM.shared.musicArray.firstIndex(where: {$0.id == Int(interest)}) {
                    categoryInterestArray?.append( CommonVM.shared.musicArray[index])
                }
            }
        }
    }
    
    func setDataForFavourite() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        return dict
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async { () -> Void in
            let eventStore = EKEventStore()
            
            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.notes = description
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let err as NSError {
                        completion?(false, err)
                        return
                    }
                    completion?(true, nil)
                } else {
                    completion?(false, error as NSError?)
                }
            })
        }
    }
    
    //MARK: IBActions
    @IBAction func playButtonAction(_ sender: UIButton) {
        if type == .search {
            if categoryEventDetailArray[selectedIndex].eventVideoURL != "" {
                if let url = URL(string: categoryEventDetailArray[selectedIndex].eventVideoURL ?? ""){
                    let player = AVPlayer(url: url)
                    let controller=AVPlayerViewController()
                    controller.player=player
                    player.play()
                    self.present(controller, animated: true, completion: nil)
                }
            } else {
                self.showAlert(message: "No Video Found")
            }
        } else {
            if EventVM.shared.eventDetailArray?[selectedIndex].eventVideoURL != "" {
                if let url = URL(string: EventVM.shared.eventDetailArray?[selectedIndex].eventVideoURL ?? ""){
                    let player = AVPlayer(url: url)
                    let controller=AVPlayerViewController()
                    controller.player=player
                    player.play()
                    self.present(controller, animated: true, completion: nil)
                }
            } else {
                self.showAlert(message: "No Video Found")
            }
        }
    }
    
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            sender.tag = selectedIndex
            apiToAddFavourite()
        } else {
            return
        }
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        let locationvc = self.storyboard?.instantiateViewController(withIdentifier: kDirectionVC) as! DirectionVC
        locationvc.selectedIndex = self.selectedIndex
        if type == .search {
            locationvc.categoryEventDetailArray = self.categoryEventDetailArray
            locationvc.type = .search
        }
        self.navigationController?.show(locationvc, sender: self)
    }
    
    @IBAction func attendingButtonAction(_ sender: UIButton) {
        if type == .search {
            if categoryEventDetailArray[selectedIndex].eventType == 3 {
                return
            }
        } else {
            if EventVM.shared.eventDetailArray?[selectedIndex].eventType == 3 {
                return
            }
        }
        let attendingvc = self.storyboard?.instantiateViewController(withIdentifier: kUserListVC) as! UserListVC
        attendingvc.selectedIndex = self.selectedIndex
        if type == .search {
            attendingvc.categoryEventDetailArray = self.categoryEventDetailArray
            attendingvc.type = .search
        }
        self.navigationController?.show(attendingvc, sender: self)
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        let viewpostvc = self.storyboard?.instantiateViewController(withIdentifier: kViewPostVC) as! ViewPostVC
        viewpostvc.selectedIndex = self.selectedIndex
        if type == .search {
            viewpostvc.categoryEventDetailArray = self.categoryEventDetailArray
            viewpostvc.type = .search
        }
        self.navigationController?.show(viewpostvc, sender: self)
    }
    
    @IBAction func previousNextAction(_ sender: UIButton) {
        if sender.tag == 1 { //Previous
            if type == .search {
                if categoryInterestArray?.count == 0 {
                    return
                }
            } else {
                if EventVM.shared.eventDetailArray?[selectedIndex].categories?.count == 0 {
                    return
                }
            }
            
            if index > 0 {
                collectionView.scrollToItem(at: IndexPath(row: index-1, section: 0), at: .left, animated: true)
                index -= 1
            }
        }
        else { //Next
            if type == .search {
                if categoryInterestArray?.count == 0 {
                    return
                }
            } else if EventVM.shared.eventDetailArray?[selectedIndex].categories?.count == 0 {
                return
            }
            
            if type == .search {
                if (index + 1) < categoryInterestArray?.count ?? 0 {
                    collectionView.scrollToItem(at: IndexPath(row: index+1, section: 0), at: .right, animated: true)
                    index += 1
                }
            } else {
                if (index + 1) < EventVM.shared.eventDetailArray?[selectedIndex].categories?.count ?? 0 {
                    collectionView.scrollToItem(at: IndexPath(row: index+1, section: 0), at: .right, animated: true)
                    index += 1
                }
            }
        }
    }
    
    @IBAction func scanTicketAction(_ sender: UIButton) {
        if BaseVC.userType == .organiser {
            let scanvc = self.storyboard?.instantiateViewController(withIdentifier: kScanTicketVC) as! ScanTicketVC
            self.navigationController?.show(scanvc, sender: self)
        }
        else if type == .invitation {
            
        }
        else {
            let controller = SpotifyActionController()
            let action1 = Action(ActionData(title: "TICKET"), style: .default, handler: {action in
                let storyboard = UIStoryboard(storyboard: .Payment)
                let ticketvc = storyboard.instantiateViewController(withIdentifier: kSelectTicketVC) as! SelectTicketVC
                ticketvc.selectedIndex = self.selectedIndex
                if self.type == .search {
                    ticketvc.categoryEventDetailArray = self.categoryEventDetailArray
                    ticketvc.type = .search
                }
                self.navigationController?.show(ticketvc, sender: self)
            })
            let action2 = Action(ActionData(title: "GUESTLIST"), style: .default, handler: {action in
            })
            let action3 = Action(ActionData(title: "CANCEL"), style: .default, handler: {action in
                controller.dismiss()
            })
            controller.settings.cancelView.showCancel = false
            controller.addAction(action1)
            controller.addAction(action2)
            controller.addAction(action3)
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func addToCalender(_ sender: Any) {
        addEventToCalendar(title: EventVM.shared.eventDetailArray?[selectedIndex].eventName ?? "", description: EventVM.shared.eventDetailArray?[selectedIndex].eventDescription ?? "", startDate: EventVM.shared.eventDetailArray?[selectedIndex].eventDate?.dateFromString(format: .dmyDate, type: .local) ?? Date(), endDate: EventVM.shared.eventDetailArray?[selectedIndex].eventDate?.dateFromString(format: .dmyDate, type: .local) ?? Date()) { (true, nil) in
            self.showAlert(message: "Event added to calendar successfully")
        }
    }
}

//MARK: CollectionView Datasource
extension EventDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == .search {
            return categoryInterestArray?.count ?? 0
        } else {
            return EventVM.shared.eventDetailArray?[selectedIndex].categories?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCategoryCell, for: indexPath) as! CategoryCell
        if type == .search {
            cell.iconImageView.sd_setImage(with: categoryInterestArray?[indexPath.row].image, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
            cell.nameLabel.text = categoryInterestArray?[indexPath.row].name
        } else {
            cell.iconImageView.sd_setImage(with: EventVM.shared.eventDetailArray?[selectedIndex].categories?[indexPath.row].image, placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
            cell.nameLabel.text = EventVM.shared.eventDetailArray?[selectedIndex].categories?[indexPath.row].name
        }
        return cell
    }
}

extension EventDetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPaths = collectionView.indexPathsForVisibleItems
        index = indexPaths.first?.row ?? 0
    }
    func apiToAddFavourite(){
        EventVM.shared.addToFavourite(dict: setDataForFavourite()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                
            }
        }
    }
}
