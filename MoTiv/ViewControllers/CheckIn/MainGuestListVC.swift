//
//  MainGuestListVC.swift
//  MoTiv
//
//  Created by Manish Gumbal on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class MainGuestListVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: Variables
    var selectedIndex = Int()
    var userType: CheckInUserType = .guest
    var searchText = String()
    var filteredData = [CheckInDetail]()
    var isSearching = Bool()
    
    //MAKRK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPopover(title: kAddGuestPop, sender: addButton)
        getGuestListName()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kGuestListName)
        searchTextField.set(radius: 14.0)
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kType] = userType.rawValue
        dict[APIKeys.kEventID] = EventVM.shared.checkInEventDetailArray?[selectedIndex].eventID
        return dict
    }

    //MARK: IBActions
    @IBAction func addButtonAction(_ sender: UIButton) {
        let addGuestvc = self.storyboard?.instantiateViewController(withIdentifier: kcreateGuestListVC) as! createGuestListVC
        addGuestvc.selectedIndex = self.selectedIndex
        self.navigationController?.show(addGuestvc, sender: self)
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        searchText = sender.text ?? ""
        isSearching = sender.text == "" ? false : true
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
        filteredData = EventVM.shared.checkInGuestListArray?.filter({($0.guestListName?.localizedCaseInsensitiveContains(searchText)) ?? Bool()}) ?? [CheckInDetail]()
        tableView.reloadData()
    }
}

//MARK: UITableview Datasource
extension MainGuestListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == true ? filteredData.count : EventVM.shared.checkInGuestListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGuestListcell) as! GuestListcell
        cell.guestListNameLabel.text = isSearching == true ? filteredData[indexPath.row].guestListName : EventVM.shared.checkInGuestListArray?[indexPath.row].guestListName
        return cell
    }
}

//MARK: UITableview Delegate
extension MainGuestListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let guestlistvc = self.storyboard?.instantiateViewController(withIdentifier: kGuestListVC) as! GuestListVC
        guestlistvc.guestListID = (isSearching == true ? filteredData[indexPath.row].guestListNameID : EventVM.shared.checkInGuestListArray?[indexPath.row].guestListNameID) ?? 0
        self.navigationController?.show(guestlistvc, sender: self)
    }
}

//MARK: API Methods
extension MainGuestListVC {
    func getGuestListName() {
        EventVM.shared.getCheckInDetails(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                if EventVM.shared.checkInGuestListArray?.count == 0 {
                    self.showAlert(message: "No Guest List Found")
                }
                self.tableView.reloadData()
            }
        }
    }
}
