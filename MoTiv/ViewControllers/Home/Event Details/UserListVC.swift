//
//  UserListVC.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import XLActionController

class UserListVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    
    var selectedIndex = Int()
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        getGuestList()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kAttending)
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        return dict
    }
}

//MARK: Tableview Datasource
extension UserListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.guestListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kUserCell) as! UserCell
        cell.backView.set(radius: 14.0)
        cell.nameLabel.text = EventVM.shared.guestListArray?[indexPath.row].guestName
        cell.profileImageView.sd_setImage(with: URL(string: EventVM.shared.guestListArray?[indexPath.row].guestImageURL ?? ""), placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
        return cell
    }
}
    
extension UserListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SpotifyActionController()
        let action1 = Action(ActionData(title: "VIEW PROFILE"), style: .default, handler: {action in
            let storyboard = UIStoryboard(storyboard: .Home)
            let viewvc = storyboard.instantiateViewController(withIdentifier: kViewProfileVC) as! ViewProfileVC
            self.navigationController?.show(viewvc, sender: self)
        })
        let action2 = Action(ActionData(title: "BLOCK"), style: .default, handler: {action in
            
        })
        let action3 = Action(ActionData(title: "MAKE CO-ADMIN"), style: .default, handler: {action in
            
        })
        let action4 = Action(ActionData(title: "CANCEL"), style: .default, handler: {action in
            controller.dismiss()
        })
        controller.settings.cancelView.showCancel = false
        controller.addAction(action1)
        controller.addAction(action2)
        controller.addAction(action3)
        controller.addAction(action4)
        self.present(controller, animated: true, completion: nil)
    }
}

//MARK: - API Calls
extension UserListVC {
    func getGuestList(){
        EventVM.shared.getGuestList(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.tableView.reloadData()
            }
        }
    }
}

