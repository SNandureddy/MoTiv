//
//  GuestListVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class GuestListVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var searchTextField: TextField!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var guestListID = Int()
    var searchText = String()
    var filteredData = [CheckInGuestDetail]()
    var isSearching = Bool()
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        getGuestsFromList()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kGuestList)
        setRightButton(image: #imageLiteral(resourceName: "print"))
        searchTextField.set(radius: 14.0)
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
        searchTextField.rightImage = searchTextField.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kGuestListNameID] = guestListID
        return dict
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let addGuestvc = self.storyboard?.instantiateViewController(withIdentifier: kAddGuestVC) as! AddGuestVC
        addGuestvc.guestListID = self.guestListID
        addGuestvc.guestListType = .old
        self.navigationController?.show(addGuestvc, sender: self)
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        searchText = sender.text ?? ""
        isSearching = sender.text == "" ? false : true
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "searchSelected"): #imageLiteral(resourceName: "searchUnSelected")
        filteredData = EventVM.shared.guestDetailsArray?.filter({($0.guestName?.localizedCaseInsensitiveContains(searchText)) ?? Bool()}) ?? [CheckInGuestDetail]()
        tableView.reloadData()
    }
}


//MARK: UITableview Datasource
extension GuestListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == true ? filteredData.count : EventVM.shared.guestDetailsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kGuestCell) as! GuestCell
        cell.userNameLabel.text = isSearching == true ? filteredData[indexPath.row].guestName : EventVM.shared.guestDetailsArray?[indexPath.row].guestName
        cell.uniqueIdLabel.text = isSearching == true ? "\(filteredData[indexPath.row].guestID ?? 0)" : "\(EventVM.shared.guestDetailsArray?[indexPath.row].guestID ?? 0)"
        cell.crossbutton.addTarget(self, action: #selector(self.crossButtonAction(sender:)), for: .touchUpInside)
        cell.crossbutton.tag = indexPath.row
        return cell
    }
    @objc func crossButtonAction(sender: UIButton) {
        self.showAlert(title: nil, message: kDeleteGuestMessage, cancelTitle: kNo, cancelAction: nil, okayTitle: kYes) {
            self.deleteGuestsFromList(index: sender.tag)
        }
    }
}

//MARK: UItableview Delegates
extension GuestListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //...
    }
}

//MARK: API Methods
extension GuestListVC {
    func getGuestsFromList() {
        EventVM.shared.getGuestsFromList(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.tableView.reloadData()
            }
        }
    }
    func deleteGuestsFromList(index: Int) {
        var dict = JSONDictionary()
        dict[APIKeys.kGuestId] = EventVM.shared.guestDetailsArray?[index].guestID
        EventVM.shared.deleteGuestsFromList(dict: dict){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.showAlert(title: nil, message: kGuestDeleteMessage, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
                    self.getGuestsFromList()
                }
            }
        }
    }
}
