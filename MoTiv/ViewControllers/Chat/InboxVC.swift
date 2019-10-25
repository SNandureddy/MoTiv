//
//  InboxVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class InboxVC: BaseVC {
    // MARK: - IBOutlets
 
    @IBOutlet weak var listTableView: UITableView!
    
    
    
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
        setTitle(title: kInbox)
        setRightButton(image: #imageLiteral(resourceName: "addChatUser"))
    }
    
    override func rightButtonAction(sender: UIButton) {
        let storyboard = UIStoryboard(storyboard: .Home)
        let invitevc = storyboard.instantiateViewController(withIdentifier: kInviteUserVC) as! InviteUserVC
        invitevc.type = .chat
        self.navigationController?.show(invitevc, sender: self)
    }

    
    // MARK: - IBActions
}
//MARK: UITableView Delegates & Datasources
extension InboxVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kInboxCell, for: indexPath)as!InboxCell
        cell.selectionStyle = .none
        cell.mainView.set(radius: 14.0)
        cell.mainView.setShadow()
        return cell
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kChatVC) as! ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            //....
            return
        }
        deleteButton.backgroundColor = UIColor.motivColor.darkBaseColor.color()
        return [deleteButton]
    }
}
