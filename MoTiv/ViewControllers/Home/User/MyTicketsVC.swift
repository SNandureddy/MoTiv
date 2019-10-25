//
//  MyTicketsVC.swift
//  MoTiv
//
//  Created by IOS on 10/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

enum EventListScreen: String {
    case tickets = "TICKETS"
    case past = "PAST BOOKINGS"
    case invitation = "INVITATIONS"
}

import UIKit

class MyTicketsVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var type: EventListScreen = .tickets
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: type.rawValue)
    }
}

//MARK: UITableView DataSource
extension MyTicketsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch type {
        case .tickets:
            let cell = tableView.dequeueReusableCell(withIdentifier: kMyTicketCell) as! MyTicketCell
            return cell
        case .past:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PastCell")!
            return cell
        case .invitation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InvitationCell")!
            return cell
        }
    }
}

//MARK: UITableView Delegates
extension MyTicketsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(storyboard: .Home)
        let nxtObj = storyboard.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        switch type {
        case .tickets:
            nxtObj.type = .ticket
        case .past:
            nxtObj.type = .past
        case .invitation:
            nxtObj.type = .invitation
        }
        self.navigationController?.show(nxtObj, sender: self)
    }
}
