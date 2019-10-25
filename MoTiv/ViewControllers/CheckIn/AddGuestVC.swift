//
//  AddguestVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

enum GuestListType :String {
    case new = "new"
    case old = "old"
}

class AddGuestVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var cellCount = 1
    var selectedIndex = Int()
    var guestListName = String()
    var guestlistDict : JSONDictionary = ["name" : "" , "email" : "", "organisation" : ""]
    var guestList = JSONArray()
    var guestListID = Int()
    var guestListType: GuestListType?
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guestList = [guestlistDict]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    //MARK:- IBAction
    @IBAction func addMoreButtonAction(_ sender: Any) {
        if !isValidData() {
            return
        }
        guestList.append(guestlistDict)
        self.tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: (guestList.count) - 1, section: 0), at: .bottom, animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if !isValidData() {
            return
        }
        if guestListType == .new {
            createGuestListName()
        } else {
            addGuestToGuestList()
        }
    }
    
    //MARK: Private Methods
    func customiseUI() {
        setTitle(title: kAddGuest)
        self.saveButton.setBackgroundImage(saveButton.graidentImage, for: .normal)
        self.addMoreButton.setBackgroundImage(addMoreButton.graidentImage, for: .normal)
        self.saveButton.set(radius: 14.0)
        self.addMoreButton.set(radius: 14.0)
    }
    
    func setDataToAddGuestList() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = EventVM.shared.checkInEventDetailArray?[selectedIndex].eventID
        dict[APIKeys.kGuestListName] = guestListName
        return dict
    }
    
    func setDataToAddGuest() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kAddGuest] = getObjectStringFrom(jsonArray: handleGuestData())
        dict[APIKeys.kGuestListNameID] = guestListType == .new ? EventVM.shared.guestListID : guestListID
        return dict
    }
    
    func handleGuestData() -> JSONArray {
        var guestData = JSONArray()
        for i in 0...(guestList.count) - 1 {
            let dict = [APIKeys.kFullName : guestList[i][APIKeys.kFullName] as? String ?? "", APIKeys.kEmail : guestList[i][APIKeys.kEmail] as? String ?? "", APIKeys.kOrganisation : guestList[i][APIKeys.kOrganisation] as? String ?? ""] as JSONDictionary
                guestData.append(dict)
        }
        return guestData
    }
    
    func isValidData() -> Bool {
        for data in guestList {
            if ((data[APIKeys.kFullName] as? String)?.count ?? 0) < 2 {
                showAlert(message: kNameValidation)
                return false
            }
            
            if !((data[APIKeys.kEmail] as? String)?.isValidEmail ?? Bool()) {
                showAlert(message: kEmailValidation)
                return false
            }
            
            if ((data[APIKeys.kOrganisation] as? String)?.count ?? 0) < 2 {
                showAlert(message: "Organisation must be atleast 2 characters long")
                return false
            }

        }
        return true
    }
}


//MARK: UITableview Datasource
extension AddGuestVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAddGuestCell) as! AddGuestCell
        cell.nameTextField.tag = 1
        cell.emailAddressTextField.tag = 2
        cell.organisationTextField.tag = 3
        cell.nameTextField.text = self.guestList[indexPath.row][APIKeys.kFullName] as? String
        cell.emailAddressTextField.text = self.guestList[indexPath.row][APIKeys.kEmail] as? String
        cell.organisationTextField.text = self.guestList[indexPath.row][APIKeys.kOrganisation] as? String
        cell.nameTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        cell.emailAddressTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        cell.organisationTextField.addTarget(self, action: #selector(textDidChange(textField:)), for: .editingChanged)
        return cell
    }
    
    @objc func textDidChange(textField: TextField) {
        textField.text!.count > 0 ? textField.setShadow(): textField.removeShadow()
        if let cell = textField.superview?.superview?.superview?.superview as? AddGuestCell {
            if let index = self.tableView.indexPath(for: cell) {
                if textField.tag == 1 {
                    self.guestList[index.row][APIKeys.kFullName] = textField.text
                    textField.rightImage = textField.text!.count > 0 ? #imageLiteral(resourceName: "userImageIcon"): #imageLiteral(resourceName: "userUnselected")
                }else if textField.tag == 2 {
                    self.guestList[index.row][APIKeys.kEmail] = textField.text
                    textField.rightImage = textField.text!.count > 0 ? #imageLiteral(resourceName: "mailSelected"): #imageLiteral(resourceName: "mailUnSelected")
                }else {
                    self.guestList[index.row][APIKeys.kOrganisation] = textField.text
                    textField.rightImage = textField.text!.count > 0 ? #imageLiteral(resourceName: "userImageIcon"): #imageLiteral(resourceName: "userUnselected")
                }
            }
        }
    }
}

//MARK: API Methods

extension AddGuestVC {
    func createGuestListName() {
        Indicator.isEnabledIndicator = false
        EventVM.shared.addGuestList(dict: setDataToAddGuestList()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.addGuestToGuestList()
            }
        }
    }
    
    func addGuestToGuestList() {
        Indicator.isEnabledIndicator = false
        EventVM.shared.addGuest(dict: setDataToAddGuest()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.showAlert(title: nil, message: kAddGuestSuccess, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
