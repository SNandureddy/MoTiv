//
//  O_HomeVC.swift
//  MoTiv
//
//  Created by IOS on 27/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class O_HomeVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var nowButton: UIButton!
    @IBOutlet weak var futureButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var nowBottomView: UIView!
    @IBOutlet var futureBottomView: UIView!
    
    //MARK: Variables
    var selectedTime: EventTime = .now
    var indexofPage:Int = 1

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        nowButton.isSelected = true
        futureButton.isSelected = false
        nowBottomView.isHidden = false
        futureBottomView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
        getEventList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPopover(title: kCreateMotivPop, sender: addButton)
    }

    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kMyEvents)
        setLeftButton(image: #imageLiteral(resourceName: "search"))
        setRightButton(image: #imageLiteral(resourceName: "faq"))
    }
    
    //MARK: - Private func
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventTime] = selectedTime.rawValue
        dict[APIKeys.kPage] = indexofPage
        return dict
    }
    
    override func rightButtonAction(sender: UIButton) {
        let storybaord = UIStoryboard(storyboard: .Profile)
        let faqvc = storybaord.instantiateViewController(withIdentifier: kHelpVC) as! HelpVC
        let nav = UINavigationController(rootViewController: faqvc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    //MARK: IBActions
    @IBAction func eventTypeButtonAction(_ sender: UIButton) {
        sender.isSelected = true
        if sender.tag == 1 { //NOW
            if selectedTime == .now {
                return
            }
            indexofPage = 1
            futureButton.isSelected = false
            nowBottomView.isHidden = false
            futureBottomView.isHidden = true
            self.selectedTime = .now
            EventVM.shared.eventDetailArray?.removeAll()
            self.tableView.reloadData()
            self.getEventList()
        }
        else { //FUTURE
            if selectedTime == .future {
                return
            }
            indexofPage = 1
            nowButton.isSelected = false
            nowBottomView.isHidden = true
            futureBottomView.isHidden = false
            self.selectedTime = .future
            EventVM.shared.eventDetailArray?.removeAll()
            self.tableView.reloadData()
            self.getEventList()
        }
    }
    
    @IBAction func createMoTivAction(_ sender: UIButton) {
        if !DataManager.isLoggedIn {
            self.showAlert(title: kLoginNow, message: kLoginAlert, okayTitle: kOkay) {
                self.logout()
            }
            return
        }
        let createvc = self.storyboard?.instantiateViewController(withIdentifier: kOCreateMainVC) as! O_CreateMainVC
        self.navigationController?.show(createvc, sender: self)
    }
}

//MARK: UITableview Datasource
extension O_HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.eventDetailArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kEventCell) as! EventCell
        cell.eventImage.sd_setImage(with: URL(string: EventVM.shared.eventDetailArray?[indexPath.row].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell.eventImage.set(radius: 12.0)
        cell.nameLabel.text = EventVM.shared.eventDetailArray?[indexPath.row].eventName
        cell.timeLabel.text = EventVM.shared.eventDetailArray?[indexPath.row].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .time, type: .local)
        cell.priceLabel.text = "From \(Double(EventVM.shared.eventDetailArray?[indexPath.row].ticketAmount ?? 0).roundToTwoDecimal.amountValue)"
        cell.priceLabel.isHidden = EventVM.shared.eventDetailArray?[indexPath.row].eventType == 3 ? false : true
        cell.playButton.isHidden = EventVM.shared.eventDetailArray?[indexPath.row].eventVideoURL == "" ? true : false
        cell.playButton.addTarget(self, action: #selector(self.playButtonAction(sender:)), for: .touchUpInside)
        cell.playButton.tag = indexPath.row
        return cell
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

//MARK: UItableview Delegates
extension O_HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        detailvc.selectedIndex = indexPath.row
        self.navigationController?.show(detailvc, sender: self)
    }
}

//MARK: UIScrollViewDelegate
extension O_HomeVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if EventVM.shared.total == EventVM.shared.to ?? 0 {
            return
        } else {
            if (tableView!.contentOffset.y + tableView!.frame.height) >= (tableView!.contentSize.height - 50) {
                if (EventVM.shared.eventDetailArray?.count ?? 0) > 0 {
                    getEventList()
                }
            }
        }
    }
}


//MARK: - API Calls
extension O_HomeVC {
    
    func getEventList(){
        if indexofPage == 1 {
            EventVM.shared.eventDetailArray?.removeAll()
            tableView.reloadData()
        }
        EventVM.shared.getEventList(dict: setData(), page: indexofPage){ (message, error) in
            if error != nil{
                self.indexofPage = 1
                EventVM.shared.eventDetailArray?.removeAll()
                self.tableView.reloadData()
                self.showErrorMessage(error: error)
            }
            else {
                if self.indexofPage != (EventVM.shared.eventLastPage ?? 0) {
                    self.indexofPage += 1
                }
                self.tableView.reloadData()
            }
        }
    }
}