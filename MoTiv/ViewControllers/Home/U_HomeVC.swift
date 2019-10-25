//
//  U_HomeVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

enum EventTime :String {        //    current,past,upcoming,favourite,invitiations
    case now = "current"
    case future = "upcoming"
    case favourite = "favourite"
    
}

class U_HomeVC: BaseVC {
    // MARK: - IBOutlets
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var ticketsButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var questionButton: UIButton!
    @IBOutlet weak var nowButton: UIButton!
    @IBOutlet weak var futureButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet var nowBottomView: UIView!
    @IBOutlet var futureBottomView: UIView!
    @IBOutlet var favouritesBottomView: UIView!
    
    // MARK: - Variables
    var isFirstTime = true
    var workItem: DispatchWorkItem!
    var workItem1: DispatchWorkItem!
    var workItem2: DispatchWorkItem!
    var workItem3: DispatchWorkItem!
    var workItem4: DispatchWorkItem!
    var selectedTime: EventTime = .now
    var indexofPage:Int = 1
    var selectedIndex = Int()
    var eventImage: UIImage?
    var filterDictionary = JSONDictionary()
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nowButton.isSelected = true
        nowBottomView.isHidden = false
        futureBottomView.isHidden = true
        favouritesBottomView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customizeUI()
        getEventList()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        workItem = DispatchWorkItem {
        //            self.showPopover(type: .down, title: kSupportPop, sender: self.questionButton)
        //        }
        workItem1 = DispatchWorkItem {
            self.showPopover(type: .down, title: kFilterPop, sender: self.filterButton)
        }
        workItem2 = DispatchWorkItem {
            self.showPopover(type: .down, title: kChatPop, sender: self.chatButton)
        }
        self.showPopover(type: .down, title: kTicketPop, sender: ticketsButton)
        //DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: workItem)
        DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: workItem1)
        DispatchQueue.main.asyncAfter(deadline: .now()+6, execute: workItem2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //workItem.cancel()
        workItem1.cancel()
        workItem2.cancel()
        if EventVM.shared.eventDetailArray != nil {
            if EventVM.shared.eventDetailArray?.count != 0 {
                workItem3.cancel()
                workItem4.cancel()
            }
        }
    }
    
    
    // MARK: - Private functions
    private func customizeUI() {
        self.hideNavigationBar()
        self.eventsTableView.reloadData()
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventTime] = selectedTime.rawValue
        dict[APIKeys.kPage] = indexofPage
        return dict
    }
    func setDataForFavourite(id: Int) -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = id
        return dict
    }
    
    
    // MARK: - IBActions
    
    @IBAction func ticketsButtonAction(_ sender: Any) {
        let ticketvc = self.storyboard?.instantiateViewController(withIdentifier: kMyTicketsVC) as! MyTicketsVC
        self.show(ticketvc, sender: self)
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(storyboard: .Home)
        let nextObj = storyboard.instantiateViewController(withIdentifier: kU_HomeFilterVC) as? U_HomeFilterVC
        nextObj?.delegate = self
        let navController = UINavigationController(rootViewController: nextObj!)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    @IBAction func chatButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(storyboard: .Chat)
        let vc = storyboard.instantiateViewController(withIdentifier: kInboxVC)as! InboxVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nowButtonAction(_ sender: Any) {
        if selectedTime == .now {
            return
        }
        indexofPage = 1
        nowButton.isSelected = true
        futureButton.isSelected = false
        favoriteButton.isSelected = false
        nowBottomView.isHidden = false
        futureBottomView.isHidden = true
        favouritesBottomView.isHidden = true
        self.selectedTime = .now
        EventVM.shared.eventDetailArray?.removeAll()
        self.eventsTableView.reloadData()
        self.getEventList()
    }
    @IBAction func futureButtonAction(_ sender: Any) {
        if selectedTime == .future {
            return
        }
        indexofPage = 1
        nowButton.isSelected = false
        futureButton.isSelected = true
        favoriteButton.isSelected = false
        nowBottomView.isHidden = true
        futureBottomView.isHidden = false
        favouritesBottomView.isHidden = true
        self.selectedTime = .future
        EventVM.shared.eventDetailArray?.removeAll()
        self.eventsTableView.reloadData()
        self.getEventList()
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        if selectedTime == .favourite {
            return
        }
        indexofPage = 1
        nowButton.isSelected = false
        futureButton.isSelected = false
        favoriteButton.isSelected = true
        nowBottomView.isHidden = true
        futureBottomView.isHidden = true
        favouritesBottomView.isHidden = false
        self.selectedTime = .favourite
        EventVM.shared.eventDetailArray?.removeAll()
        self.eventsTableView.reloadData()
        self.getEventList()
    }
}

//MARK: UITableView Delegates & Datasources
extension U_HomeVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.eventDetailArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kU_HomeCell, for: indexPath) as! U_HomeCell
        cell.selectionStyle = .none
        cell.playButton.isHidden = EventVM.shared.eventDetailArray?[indexPath.row].eventVideoURL == "" ? true : false
        cell.eventNameLabel.text = EventVM.shared.eventDetailArray?[indexPath.row].eventName
        cell.timeLabel.text = EventVM.shared.eventDetailArray?[indexPath.row].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .time, type: .local)
        cell.priceLabel.text = "From \(Double(EventVM.shared.eventDetailArray?[indexPath.row].ticketAmount ?? 0).roundToTwoDecimal.amountValue)"
        cell.priceLabel.isHidden = EventVM.shared.eventDetailArray?[indexPath.row].eventType == 3 ? false : true
        cell.eventImageView?.sd_setImage(with: URL(string: EventVM.shared.eventDetailArray?[indexPath.row].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell.eventImageView.set(radius: 12.0)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(self.likeButtonAction(sender:)), for: .touchUpInside)
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(self.shareButtonAction(sender:)), for: .touchUpInside)
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(self.playButtonAction(sender:)), for: .touchUpInside)
        
        if (EventVM.shared.eventDetailArray != nil || EventVM.shared.eventDetailArray?.count != 0) && indexPath.row == 0 && isFirstTime {
            isFirstTime = false
            workItem3 = DispatchWorkItem {
                self.showPopover(type: .down, title: kFavouritePop, sender: cell.likeButton)
            }
            workItem4 = DispatchWorkItem {
                self.showPopover(type: .down, title: kSharePop, sender: cell.shareButton)
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: workItem3)
            DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: workItem4)
        }
        cell.likeButton.isSelected = EventVM.shared.eventDetailArray?[indexPath.row].favouriteStatus == 1 ? true : false
        return cell
    }
    
    @objc func likeButtonAction(sender: UIButton) {
        if sender.isSelected {
            return
        }
        sender.isSelected = true
        apiToAddFavourite(id: EventVM.shared.eventDetailArray?[sender.tag].eventID ?? 0)
    }
    @objc func shareButtonAction(sender: UIButton) {
        let cell = sender.superview?.superview as? U_HomeCell
        let shareText = "Hi, I've created a new event \(EventVM.shared.eventDetailArray?[selectedIndex].eventName ?? "")"
        cell?.eventImageView?.sd_setImage(with: URL(string: EventVM.shared.eventDetailArray?[sender.tag].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        eventImage = cell?.eventImageView.image
        if let image = eventImage {
            let vc = UIActivityViewController(activityItems: [shareText, image], applicationActivities: nil)
            present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func playButtonAction(sender: UIButton) {
        if let url = URL(string: EventVM.shared.eventDetailArray?[sender.tag].eventVideoURL ?? ""){
            let player = AVPlayer(url: url)
            let controller=AVPlayerViewController()
            controller.player=player
            player.play()
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension U_HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        detailvc.selectedIndex = indexPath.row
        detailvc.selectedTime = self.selectedTime
        self.navigationController?.show(detailvc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: UIScrollViewDelegate
extension U_HomeVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if EventVM.shared.total == EventVM.shared.to ?? 0 {
            return
        } else {
            if (eventsTableView!.contentOffset.y + eventsTableView!.frame.height) >= (eventsTableView!.contentSize.height - 50) {
                if (EventVM.shared.eventDetailArray?.count ?? 0) > 0 {
                    getEventList()
                }
            }
        }
    }
}


//MARK: - API Calls
extension U_HomeVC {
    
    func getEventList(){
        if indexofPage == 1 {
            EventVM.shared.eventDetailArray?.removeAll()
            self.eventsTableView.reloadData()
        }
        filterDictionary[APIKeys.kEventTime] = selectedTime.rawValue
        filterDictionary[APIKeys.kPage] = indexofPage
        EventVM.shared.getEventList(dict: filterDictionary, page: indexofPage){ (message, error) in
            if error != nil{
                self.indexofPage = 1
                EventVM.shared.eventDetailArray?.removeAll()
                self.eventsTableView.reloadData()
                self.showErrorMessage(error: error)
            } else{
                if self.indexofPage != (EventVM.shared.eventLastPage ?? 0) {
                    self.indexofPage += 1
                }
                self.eventsTableView.reloadData()
            }
        }
    }
    
    func apiToAddFavourite(id: Int){
        EventVM.shared.addToFavourite(dict: setDataForFavourite(id: id)){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                
            }
        }
    }
}

//MARK: U_HomeFilter Delegates
extension U_HomeVC : U_HomeFilterDelegate {
    func setFilteredData(object: JSONDictionary) {
        self.filterDictionary = object
        if U_HomeFilterVC.filter == "1" {
            self.indexofPage = 1
        }
        self.getEventList()
    }
}
