//
//  NotificationVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class NotificationVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        self.hideRightButton()
        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
            setTitle(title: kNotifications, showBack: false)
        }
        else {
            setTitle(title: kNotifications)
        }
    }
}

//MARK: UITableview Datasource
extension NotificationVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kNotificationCell) as! NotificationCell
        cell.backView.set(radius: 14.0)
        cell.backView.setShadow()
        return cell
    }
}

//MARK: UItableview Delegates
extension NotificationVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

