//
//  AddFriendVC.swift
//  MoTiv
//
//  Created by IOS on 11/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import XLActionController

class AddFriendVC: BaseVC {
    
    @IBOutlet weak var searchTextField: TextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        
    }
    
    private func customiseUI() {
        setTitle(title: kAddFriend)
        searchTextField.set(radius: 14.0)
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
    }
    

    @IBAction func textDidChange(_ sender: TextField) {
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
    }
}

//MARK: Tableview Datasource
extension AddFriendVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kInviteUserCell) as! InviteUserCell
        cell.baseView.set(radius: 14.0)
        cell.baseView.setShadow()
        return cell
    }
}

//MARK: Tableview Delegates
extension AddFriendVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SpotifyActionController()
        let action1 = Action(ActionData(title: "VIEW PROFILE"), style: .default, handler: {action in
            let storyboard = UIStoryboard(storyboard: .Home)
            let viewvc = storyboard.instantiateViewController(withIdentifier: kViewProfileVC) as! ViewProfileVC
            self.navigationController?.show(viewvc, sender: self)
        })
        let action2 = Action(ActionData(title: "ADD FRIEND REQUEST"), style: .default, handler: {action in
            self.showAlert(title: kSuccess, message: kAddFriendSuccessAlert, okayTitle: kOkay, {
                self.navigationController?.popViewController(animated: true)
            })
        })
        let action4 = Action(ActionData(title: "CANCEL"), style: .default, handler: {action in
            controller.dismiss()
        })
        controller.settings.cancelView.showCancel = false
        controller.addAction(action1)
        controller.addAction(action2)
        controller.addAction(action4)
        self.present(controller, animated: true, completion: nil)
    }
}


