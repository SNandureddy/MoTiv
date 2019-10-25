//
//  SearchProfileFriendsVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import XLActionController

class SearchProfileFriendsVC: BaseVC {
    // MARK: - IBOutlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchTextField: TextField!
    
    
    // MARK: - Variables
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.customizeUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Private functions
    private func customizeUI() {
        setTitle(title: kMyProfile)
        setRightButton(image: #imageLiteral(resourceName: "addChatUser"))
        searchTextField.set(radius: 14.0)
    }
    
    override func rightButtonAction(sender: UIButton) {
        let storyboard = UIStoryboard(storyboard: .Profile)
        let invitevc = storyboard.instantiateViewController(withIdentifier: kAddFriendVC) as! AddFriendVC
        self.navigationController?.show(invitevc, sender: self)
    }
    
    // MARK: - IBActions
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected") : #imageLiteral(resourceName: "searchUnSelected")
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
    }
}

//MARK: UITableView Delegates & Datasources
extension SearchProfileFriendsVC: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: kPendingSearchFriendCell, for: indexPath)as!PendingSearchFriendCell
            cell.selectionStyle = .none
            cell.mainView.set(radius: 14.0)
            cell.mainView.setShadow()
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: kSearchFriendCell, for: indexPath)as!SearchFriendCell
            cell.selectionStyle = .none
            cell.mainView.set(radius: 14.0)
            cell.mainView.setShadow()
            return cell
        }
    }
}

extension SearchProfileFriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SpotifyActionController()
        let action1 = Action(ActionData(title: "VIEW PROFILE"), style: .default, handler: {action in
            let storyboard = UIStoryboard(storyboard: .Home)
            let viewvc = storyboard.instantiateViewController(withIdentifier: kViewProfileVC) as! ViewProfileVC
            self.navigationController?.show(viewvc, sender: self)
        })
        let action2 = Action(ActionData(title: "BLOCK"), style: .default, handler: {action in
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

extension SearchProfileFriendsVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}