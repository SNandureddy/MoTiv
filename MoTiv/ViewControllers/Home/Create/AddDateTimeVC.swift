//
//  AddDateTimeVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class AddDateTimeVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var startDateTextField: TextField!
    @IBOutlet weak var endDateTextField: TextField!
    @IBOutlet weak var renewTextField: TextField!
    @IBOutlet weak var urlTextField: TextField!
    @IBOutlet weak var phoneTextField: TextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //User Module
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nxtButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    //MARK: Variables
    var delegate: TabViewDelegate!
    var index = 0
    var interestArray = [Interest]()
    var selectedCategoriesArray = [Int]()
    var startDate = Date()
    var endDate: Date?
    var selectedField = "start"
    var renewIndex = 0
    var isUpdate = false
    var selectedIndex = Int()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpdateEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        
        if BaseVC.userType == .organiser {
            collectionHeightConstraint.constant = 0.0
            categoryCollectionView.isHidden = true
            nxtButton.isHidden = true
            previousButton.isHidden = true
            urlTextField.isHidden = true
        } else {
            getPublicInterest()
        }
        self.pickerDelegate = self
        startDateTextField.set(radius: 14.0)
        endDateTextField.set(radius: 14.0)
        renewTextField.set(radius: 14.0)
        phoneTextField.set(radius: 14.0)
        urlTextField.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setupTextField()
    }
    
    private func setupTextField() {
        phoneTextField.text!.count > 0 ? phoneTextField.setShadow(): phoneTextField.removeShadow()
        phoneTextField.text!.count > 0 ? phoneTextField.removeBackground(): phoneTextField.addBackground()
        urlTextField.text!.count > 0 ? urlTextField.setShadow(): urlTextField.removeShadow()
        urlTextField.text!.count > 0 ? urlTextField.removeBackground(): urlTextField.addBackground()
        renewTextField.text!.count > 0 ? renewTextField.setShadow(): renewTextField.removeShadow()
        renewTextField.text!.count > 0 ? renewTextField.removeBackground(): renewTextField.addBackground()
        startDateTextField.text!.count > 0 ? startDateTextField.setShadow(): startDateTextField.removeShadow()
        startDateTextField.text!.count > 0 ? startDateTextField.removeBackground(): startDateTextField.addBackground()
        endDateTextField.text!.count > 0 ? endDateTextField.setShadow(): endDateTextField.removeShadow()
        endDateTextField.text!.count > 0 ? endDateTextField.removeBackground(): endDateTextField.addBackground()
    }

    func setUpdateEvent() {
        if isUpdate == true {
            startDateTextField.text = EventVM.shared.eventDetailArray?[selectedIndex].eventDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .motivDateTime, type: .local)
            O_CreateMainVC.createDict[APIKeys.kEventStartDate] = EventVM.shared.eventDetailArray?[selectedIndex].eventDateTime
            endDateTextField.text = EventVM.shared.eventDetailArray?[selectedIndex].eventEndDateTime?.dateFromString(format: .dateTime, type: .local).stringFromDate(format: .motivDateTime, type: .local)
            O_CreateMainVC.createDict[APIKeys.kEventEndDate] = EventVM.shared.eventDetailArray?[selectedIndex].eventEndDateTime
            let index = repeatIdArray.firstIndex(of: EventVM.shared.eventDetailArray?[selectedIndex].repeatInterval ?? "")
            renewTextField.text = repeatArray[index ?? 0]
            O_CreateMainVC.createDict[APIKeys.kRenewValue] = repeatArray[renewIndex]
            O_CreateMainVC.createDict[APIKeys.kRepeatInterval] = repeatIdArray[renewIndex]
            phoneTextField.text = EventVM.shared.eventDetailArray?[selectedIndex].contactNumber
        }
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        delegate.didClickTab(tag: 5)
    }
    
    @IBAction func textFieldDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.text!.count > 0 ? sender.removeBackground(): sender.addBackground()
    }
    
    @IBAction func prevNextAction(_ sender: UIButton) {
        if sender.tag == 1 { //Previous
            if index > 0 {
                categoryCollectionView.scrollToItem(at: IndexPath(row: index-1, section: 0), at: .left, animated: true)
                index -= 1
            }
        }
        else { //Next
            if index < 9 {
                categoryCollectionView.scrollToItem(at: IndexPath(row: index+1, section: 0), at: .right, animated: true)
                index += 1
            }
        }
    }
}

extension AddDateTimeVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startDateTextField {
            endDateTextField.text = ""
            endDate = nil
            selectedField = "start"
            setDatePicker(textField: textField, mode: .dateAndTime, date: startDate, minDate: Date())
            startDateTextField.text = startDate.stringFromDate(format: .motivDateTime, type: .local)
            O_CreateMainVC.createDict[APIKeys.kEventStartDate] = startDate.stringFromDate(format: .dateTime, type: .local)
        }
        else if textField == endDateTextField {
            selectedField = "end"
            setDatePicker(textField: textField, mode: .dateAndTime, date: endDate ?? startDate, minDate: startDate)
            endDateTextField.text = (endDate ?? startDate).stringFromDate(format: .motivDateTime, type: .local)
            O_CreateMainVC.createDict[APIKeys.kEventEndDate] = (endDate ?? startDate).stringFromDate(format: .dateTime, type: .local)
        }
        else if textField == renewTextField {
            self.setPicker(textField: textField, array: repeatArray, defaultIndex: renewIndex)
            renewTextField.text = repeatArray[renewIndex]
            O_CreateMainVC.createDict[APIKeys.kRenewValue] = repeatArray[renewIndex]
            O_CreateMainVC.createDict[APIKeys.kRepeatInterval] = repeatIdArray[renewIndex]
        }
        setupTextField()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextField {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 14
        }
        return true
    }

}

extension AddDateTimeVC: PickerDelegate {
    
    func didSelectDatePicker(date: Date) {
        if selectedField == "start" {
            startDateTextField.text = date.stringFromDate(format: .motivDateTime, type: .local)
            startDate = date
            O_CreateMainVC.createDict[APIKeys.kEventStartDate] = date.stringFromDate(format: .dateTime, type: .local)
        }
        else {
            endDateTextField.text = date.stringFromDate(format: .motivDateTime, type: .local)
            endDate = date
            O_CreateMainVC.createDict[APIKeys.kEventEndDate] = date.stringFromDate(format: .dateTime, type: .local)
        }
        setupTextField()
    }
    
    func didSelectPickerViewAtIndex(index: Int) {
        renewTextField.text = repeatArray[index]
        O_CreateMainVC.createDict[APIKeys.kRepeatInterval] = repeatIdArray[index]
        O_CreateMainVC.createDict[APIKeys.kRenewValue] = repeatArray[index]
        renewIndex = index
        setupTextField()
    }
}



//MARK: CollectionView Datasource
extension AddDateTimeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interestArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCategoryCell, for: indexPath) as! CategoryCell
        cell.nameLabel.text = interestArray[indexPath.row].name
        cell.iconImageView.sd_setImage(with: interestArray[indexPath.row].image, placeholderImage: #imageLiteral(resourceName: "categoryPlaceholder"), options: .refreshCached) { (image, error, type, url) in
            cell.iconImageView.image = image?.withRenderingMode(.alwaysTemplate)
        }
        cell.iconImageView.tintColor = selectedCategoriesArray.contains(interestArray[indexPath.row].id ?? 0) ? UIColor.motivColor.baseColor.color(): UIColor.white
        return cell
    }
}

extension AddDateTimeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPaths = categoryCollectionView.indexPathsForVisibleItems
        index = indexPaths.first?.row ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        if let index = selectedCategoriesArray.firstIndex(where: {$0 == interestArray[indexPath.row].id}) {
            selectedCategoriesArray.remove(at: index)
            cell.iconImageView.tintColor = UIColor.white
        }
        else {
            selectedCategoriesArray.append(interestArray[indexPath.row].id)
            cell.iconImageView.image?.withRenderingMode(.alwaysTemplate)
            cell.iconImageView.tintColor = UIColor.motivColor.baseColor.color()
        }
    }
}

extension AddDateTimeVC {
    
    func validateData() -> String? {
        if startDateTextField.text!.count == 0 {
            return kStartDateValidation
        }
        if endDateTextField.text!.count == 0 {
            return kEndDateValidation
        }
        if renewTextField.text!.count == 0 {
            return kRenewListingValidation
        }
        if phoneTextField.text!.count > 0 && !phoneTextField.isValidPhone {
            return kPhoneValidation
        }
        O_CreateMainVC.createDict[APIKeys.kURL] = urlTextField.text!
        O_CreateMainVC.createDict[APIKeys.kContactNumber] = phoneTextField.text!
        var stringArray = selectedCategoriesArray.map { String($0) }
        O_CreateMainVC.createDict[APIKeys.kPublicInterest] = stringArray.joined(separator: ",")
        return nil
    }
}

extension AddDateTimeVC {
    
    func getPublicInterest() {
        CommonVM.shared.getPublicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.interestArray.removeAll()
                self.interestArray.append(contentsOf: CommonVM.shared.publicArray)
                //self.getMusicInterest()
                 self.categoryCollectionView.reloadData()
            }
        }
    }
    
//    func getMusicInterest() {
//        CommonVM.shared.getMusicInterest { (message, error) in
//            if error != nil {
//                self.showErrorMessage(error: error)
//            }
//            else {
//                self.interestArray.append(contentsOf: CommonVM.shared.musicArray)
//                self.categoryCollectionView.reloadData()
//            }
//        }
//    }
}