//
//  CheckinHomeVC.swift
//  MoTiv
//
//  Created by IOS on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class CheckinHomeVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var indexofPage:Int = 1

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCheckInEventList()
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        self.parent?.navigationItem.rightBarButtonItems = nil
        self.parent?.navigationItem.leftBarButtonItems = nil
        setTitle(title: kCheckIn, showBack: false)
    }
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kPage] = indexofPage
        return dict
    }
}

//MARK: UItableveiw datasource
extension CheckinHomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.checkInEventDetailArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCheckinEventCell) as! CheckinEventCell
        cell.nameLabel.text = EventVM.shared.checkInEventDetailArray?[indexPath.row].eventName
        cell.timeLabel.text = EventVM.shared.checkInEventDetailArray?[indexPath.row].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .time, type: .local)
        cell.eventImage.sd_setImage(with: URL(string: EventVM.shared.checkInEventDetailArray?[indexPath.row].eventImageURL ?? ""), placeholderImage: #imageLiteral(resourceName: "imagePlaceholder"), options: .cacheMemoryOnly, completed: nil)
        cell.eventImage.set(radius: 12.0)
        cell.ticketSoldLabel.text = "TICKETS SOLD: \(EventVM.shared.checkInEventDetailArray?[indexPath.row].ticketSoldCount ?? 0)"
        cell.guestListLabel.text = "GUEST LIST: \(EventVM.shared.checkInEventDetailArray?[indexPath.row].guestCount ?? 0)"
        cell.playButton.isHidden = EventVM.shared.checkInEventDetailArray?[indexPath.row].eventVideoURL == "" ? true : false
        cell.playButton.tag = indexPath.row
        cell.playButton.addTarget(self, action: #selector(self.playButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func playButtonAction(sender: UIButton) {
        if let url = URL(string: EventVM.shared.checkInEventDetailArray?[sender.tag].eventVideoURL ?? ""){
            let player = AVPlayer(url: url)
            let controller=AVPlayerViewController()
            controller.player=player
            player.play()
            self.present(controller, animated: true, completion: nil)
        }
    }
}

//MARK: UITableview Delegates
extension CheckinHomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuvc = self.storyboard?.instantiateViewController(withIdentifier: kEventMenuVC) as! EventMenuVC
        menuvc.selectedIndex = indexPath.row
        self.navigationController?.show(menuvc, sender: self)
    }
}

//MARK: UIScrollViewDelegate
extension CheckinHomeVC {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if EventVM.shared.total == EventVM.shared.to ?? 0 {
            return
        } else {
            if (tableView!.contentOffset.y + tableView!.frame.height) >= (tableView!.contentSize.height - 50) {
                if (EventVM.shared.checkInEventDetailArray?.count ?? 0) > 0 {
                    getCheckInEventList()
                }
            }
        }
    }
}

//MARK: API Methods
extension CheckinHomeVC {
    func getCheckInEventList(){
        if indexofPage == 1 {
            EventVM.shared.checkInEventDetailArray?.removeAll()
            self.tableView.reloadData()
        }
        EventVM.shared.getCheckInEventList(dict: setData(), page: indexofPage){ (message, error) in
            if error != nil{
                self.indexofPage = 1
                EventVM.shared.checkInEventDetailArray?.removeAll()
                self.tableView.reloadData()
                self.showErrorMessage(error: error)
            } else{
                if self.indexofPage != (EventVM.shared.eventLastPage ?? 0) {
                    self.indexofPage += 1
                }
                self.tableView.reloadData()
            }
        }
    }

}
