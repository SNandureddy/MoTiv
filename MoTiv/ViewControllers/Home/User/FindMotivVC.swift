//
//  FindMotivVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class FindMotivVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchTextField: TextField!
    
    // MARK: - Variables
    var indexofPage:Int = 1
    var userCategoriesArray = [Interest]()
    var filterDictionary = JSONDictionary()
    var searchDictionary = [String: [SearchEventDetail]]()
    var searchText = String()
    var isSearching = Bool()
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customizeUI()
        getPublicInterest()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userCategoriesArray.removeAll()
    }
    
    // MARK: - Private functions
    private func customizeUI() {
        self.hideNavigationBar()
        searchTextField.set(radius: 14.0)
        searchTextField.rightImage = searchTextField.text!.count > 0 ?  #imageLiteral(resourceName: "searchSelected") : #imageLiteral(resourceName: "searchUnSelected")
        searchTextField.text!.count > 0 ? searchTextField.setShadow(): searchTextField.removeShadow()
    }
    
    private func handleCategories() {
        for interest in DataManager.userPublicInterests {
            if let index = CommonVM.shared.publicArray.firstIndex(where: {$0.id == Int(interest)}) {
                userCategoriesArray.append( CommonVM.shared.publicArray[index])
            }
        }
        for interest in DataManager.userMusicInterests {
            if let index = CommonVM.shared.musicArray.firstIndex(where: {$0.id == Int(interest)}) {
                userCategoriesArray.append( CommonVM.shared.musicArray[index])
            }
        }
    }
    
    private func getCategoryName(id: Int) -> String {
        if let index = CommonVM.shared.musicArray.firstIndex(where: {$0.id == id}) {
            return CommonVM.shared.musicArray[index].name
        }
        if let index = CommonVM.shared.publicArray.firstIndex(where: {$0.id == id}) {
            return CommonVM.shared.publicArray[index].name
        }
        return  ""
    }
    
    // MARK: - IBActions
    @IBAction func textDidChange(_ sender: TextField) {
        sender.rightImage = sender.text!.count > 0 ?  #imageLiteral(resourceName: "searchSelected") : #imageLiteral(resourceName: "searchUnSelected")
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        searchText = sender.text ?? ""
        searchDictionary.removeAll()
        for(key, value) in EventVM.shared.categoryEventDictionary {
            let array = value.filter({($0.eventName?.localizedCaseInsensitiveContains(searchText)) ?? Bool()})
            if array.count > 0 {
                searchDictionary[key] = array
            }
        }
        if searchDictionary.count == 0 && searchText.count != 0 {
            sender.resignFirstResponder()
            showAlert(title: kError, message: "NO MORE EVENT FOUND", cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, nil)
        }
        isSearching = sender.text != "" ? true : false
        listTableView.reloadData()
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(storyboard: .Home)
        let nextObj = storyboard.instantiateViewController(withIdentifier: kU_HomeFilterVC) as? U_HomeFilterVC
        nextObj?.delegate = self
        nextObj?.previousScreen = .search
        let navController = UINavigationController(rootViewController: nextObj!)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
}

//MARK: UITableView Delegates & Datasources
extension FindMotivVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching == true ? searchDictionary.count : EventVM.shared.categoryEventDictionary.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSearchEventCell, for: indexPath)as!SearchEventCell
        cell.selectionStyle = .none
        cell.navigationController = navigationController!
        let keys = isSearching == true ? Array(searchDictionary.keys) : Array(EventVM.shared.categoryEventDictionary.keys)
        cell.categoryEventDetailArray = (isSearching == true ? searchDictionary[keys[indexPath.section]]! : EventVM.shared.categoryEventDictionary[keys[indexPath.section]]!)
        cell.eventCollectionView.reloadData()
        let height = cell.eventCollectionView.collectionViewLayout.collectionViewContentSize.height
        cell.collectionViewHeightConstraint.constant = height
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSectionCell)as!SectionCell
        cell.selectionStyle = .none
        let keys = Array(EventVM.shared.categoryEventDictionary.keys)
        cell.titleLabel.text = keys[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
}

//MARK: UITextField Delegates
extension FindMotivVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

//MARK: API Methods
extension FindMotivVC {
    
    func callApiToSearchEvent(){
        //Add Search Text
        self.filterDictionary[APIKeys.kName] = searchTextField.text ?? ""
        //Call API
        EventVM.shared.getSearchEventList(dict: filterDictionary){ (message, error) in
            if error != nil{
                EventVM.shared.categoryEventDictionary.removeAll()
                self.listTableView.reloadData()
                self.showErrorMessage(error: error)
            } else {
                self.listTableView.reloadData()
            }
        }
    }
    
    func getPublicInterest() {
        CommonVM.shared.getPublicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.getMusicInterest()
                self.handleCategories()
                self.listTableView.reloadData()
            }
        }
    }
    
    func getMusicInterest() {
        CommonVM.shared.getMusicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.callApiToSearchEvent()
            }
        }
    }
}

//MARK: U_HomeFilter Delegates
extension FindMotivVC : U_HomeFilterDelegate {
    func setFilteredData(object: JSONDictionary) {
        self.filterDictionary = object
        self.callApiToSearchEvent()
    }
}
