//
//  CheckInVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

enum CheckInUserType :Int {
    case user = 1
    case guest = 2
}

class CheckInVC: BaseVC {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var scanButtonView: UIView!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet var totalRevenueLabel: UILabel!
    @IBOutlet var checkInsLabel: UILabel!
    
    //MARK: Variables
    var userType: CheckInUserType = .user
    var selectedIndex = Int()
    var searchText = String()
    var filteredData = [CheckInDetail]()
    var isSearching = false
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCheckInDetails()
        self.showPopover(title: kScanPop, sender: scanButtonView)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kCheckIn)
        setRightButton(image: #imageLiteral(resourceName: "print"))
        self.scanButtonView.layer.cornerRadius = scanButtonView.half
        self.searchTextField.set(radius: 14.0)
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kType] = userType.rawValue
        dict[APIKeys.kEventID] = EventVM.shared.checkInEventDetailArray?[selectedIndex].eventID
        return dict
    }

    
    @IBAction func changeTypeButtonAction(_ sender: UIButton) {
        if sender.tag == 1 {
            if userType != .user {
                userType = .user
                getCheckInDetails()
            }
            userButton.backgroundColor = UIColor.motivColor.darkBaseColor.color()
            guestButton.backgroundColor = UIColor.motivColor.baseColor.color()
        }
        else {
            if userType != .guest {
                userType = .guest
                getCheckInDetails()
            }
            userButton.backgroundColor = UIColor.motivColor.baseColor.color()
            guestButton.backgroundColor = UIColor.motivColor.darkBaseColor.color()
        }
        tableView.reloadData()
    }
    
    
    @IBAction func scanTicketAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(storyboard: .Home)
        let scanvc = storyboard.instantiateViewController(withIdentifier: kScanTicketVC) as! ScanTicketVC
        scanvc.selectedIndex = self.selectedIndex
        scanvc.previousScreen = .checkin
        self.navigationController?.show(scanvc, sender: true)
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        searchText = sender.text ?? ""
        isSearching = sender.text == "" ? false : true
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
        if userType == .user {
            filteredData = EventVM.shared.checkInUserDetailArray?.filter({($0.userName?.localizedCaseInsensitiveContains(searchText)) ?? Bool()}) ?? [CheckInDetail]()
        } else {
            filteredData = EventVM.shared.checkInGuestListArray?.filter({($0.guestListName?.localizedCaseInsensitiveContains(searchText)) ?? Bool()}) ?? [CheckInDetail]()
        }
        tableView.reloadData()
    }
}


//MARK: UITableview Datasource
extension CheckInVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userType == .user {
            return isSearching == true ? filteredData.count : EventVM.shared.checkInUserDetailArray?.count ?? 0
        } else {
            return isSearching == true ? filteredData.count : EventVM.shared.checkInGuestListArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  userType == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCheckInCell) as! CheckInCell
            cell.nameLabel.text = isSearching == true ? filteredData[indexPath.row].userName : EventVM.shared.checkInUserDetailArray?[indexPath.row].userName
            cell.ticketNameLabel.text = isSearching == true ? filteredData[indexPath.row].ticketName : EventVM.shared.checkInUserDetailArray?[indexPath.row].ticketName
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kGuestListcell) as! GuestListcell
            cell.guestListNameLabel.text = isSearching == true ? filteredData[indexPath.row].guestListName : EventVM.shared.checkInGuestListArray?[indexPath.row].guestListName
            return cell
        }
    }
}

//MARK: UItableview Delegates
extension CheckInVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  userType == .guest {
            let guestlistvc = self.storyboard?.instantiateViewController(withIdentifier: kGuestListVC) as! GuestListVC
            guestlistvc.guestListID = (isSearching == true ? filteredData[indexPath.row].guestListNameID : EventVM.shared.checkInGuestListArray?[indexPath.row].guestListNameID) ?? 0
            self.navigationController?.show(guestlistvc, sender: self)
        }
    }
}

//MARK: API Methods
extension CheckInVC {
    func getCheckInDetails() {
        EventVM.shared.getCheckInDetails(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.searchTextField.text = ""
                self.isSearching = false
                self.searchTextField.resignFirstResponder()
                if self.userType == .user && EventVM.shared.checkInUserDetailArray?.count == 0 {
                    self.showAlert(message: "No User Found")
                } else if self.userType == .guest && EventVM.shared.checkInGuestListArray?.count == 0 {
                    self.showAlert(message: "No Guest Found")
                }
                self.checkInsLabel.text = "CHECK-INS ON THE DEVICE: \(EventVM.shared.totalCheckIns ?? 0)"
                self.totalRevenueLabel.text = "TOTAL REVENUE GENERATED: \(Double(EventVM.shared.totalRevenue ?? 0).roundToTwoDecimal.amountValue)"
                self.tableView.reloadData()
            }
        }
    }
}