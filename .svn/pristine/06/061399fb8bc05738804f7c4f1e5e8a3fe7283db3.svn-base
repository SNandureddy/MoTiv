//
//  InviteUserVC.swift
//  MoTiv
//
//  Created by IOS on 08/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

enum InviteScreenType: String {
    case invite = "INVITE FRIENDS"
    case add = "ADD FRIENDS"
    case chat = "SELECT USER"
    case friends = "INVITE FRIENDS."
}

import UIKit

class InviteUserVC: BaseVC {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    
    var type: InviteScreenType = .invite
    
    //MARK: Variables
    var delegate: TabViewDelegate!
    var indexArray = [Int]()
    
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
        setTitle(title: type.rawValue.replacingOccurrences(of: ".", with: ""))
        if type != .invite {
            backImageView.image = #imageLiteral(resourceName: "backgroundImage")
        }
        else {
            
        }
        nextButton.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if type == .friends {
            self.showAlert(title: kSuccess, message: "INVITATION SENT TO 5 FRIENDS", okayTitle: kOkay) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        else if type == .invite {
            let viewmotiv = self.storyboard?.instantiateViewController(withIdentifier: kViewMotivVC) as! ViewMotivVC
            self.navigationController?.show(viewmotiv, sender: self)
        }
    }
}

//MARK: Tableview Datasource
extension InviteUserVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == .invite {
            self.tableView.showEmptyScreen()
            return 0
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .friends && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "selectAllCell")!
            (cell.viewWithTag(100)!).set(radius: 14.0)
            (cell.viewWithTag(100)!).setShadow()
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: kInviteUserCell) as! InviteUserCell
        cell.baseView.set(radius: 14.0)
        cell.baseView.setShadow()
        cell.tickIcon.isHidden = !indexArray.contains(indexPath.row)
        return cell
    }
}

//MARK: Tableview Delegates
extension InviteUserVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch type {
        case .invite:
            let cell = tableView.cellForRow(at: indexPath) as! InviteUserCell
            if let index = indexArray.firstIndex(of: indexPath.row) {
                indexArray.remove(at: index)
            }
            else {
                indexArray.append(indexPath.row)
            }
            cell.tickIcon.isHidden = !cell.tickIcon.isHidden
            break
        case .add:
            self.showAlert(title: kAddFriend, message: kAddFriendAlert, cancelTitle: kCancel, cancelAction: nil, okayTitle: kYes) {
                self.showAlert(title: kSuccess, message: kAddFriendSuccessAlert, okayTitle: kOkay, {
                    self.navigationController?.popViewController(animated: true)
                })
            }
            break
        case .chat:
            let storyboard = UIStoryboard(storyboard: .Chat)
            let chatvc = storyboard.instantiateViewController(withIdentifier: kChatVC) as! ChatVC
            self.navigationController?.show(chatvc, sender: self)
            break
        case .friends:
            break
        }
    }
}
