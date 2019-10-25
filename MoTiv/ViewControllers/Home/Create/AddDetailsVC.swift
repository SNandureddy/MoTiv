//
//  AddDetailsVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

protocol CategoryDelegate {
    func didGetCategories(array: [Int], type: CategoryType)
}

class AddDetailsVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var categoriesTextField: TextField!
    @IBOutlet weak var musicTextField: TextField!
    @IBOutlet weak var dressCodeTextField: TextField!
    @IBOutlet weak var idTextField: TextField!
    @IBOutlet weak var ageTextField: TextField!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Variables
    var selectedTextField = TextField()
    var delegate: TabViewDelegate!
    var selectedPublicArray = [Int]()
    var selectedMusicArray = [Int]()
    var categoryDelegate : CategoryDelegate?
    var dressIndex = 0
    var idIndex = 0
    var isUpdate = false
    var selectedIndex = Int()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPublicInterest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        categoriesTextField.set(radius: 14.0)
        musicTextField.set(radius: 14.0)
        dressCodeTextField.set(radius: 14.0)
        idTextField.set(radius: 14.0)
        ageTextField.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        backView.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setupTextField()
    }
    
    private func setCategoryForUpdate(array: [Int], type: CategoryType) {
        if isUpdate {
            backgroundImageView.sd_setImage(with: URL(string: EventVM.shared.eventDetailArray?[selectedIndex].eventThemeURL ?? ""), placeholderImage: nil, options: .cacheMemoryOnly, completed: nil)
            O_CreateMainVC.imageDict[APIKeys.kEventTheme] = backgroundImageView.image?.imageData
            descriptionTextView.text = EventVM.shared.eventDetailArray?[selectedIndex].eventDescription ?? ""
            dressIndex = dressCodeArray.firstIndex(of: EventVM.shared.eventDetailArray?[selectedIndex].dressCode ?? "") ?? 0
            dressCodeTextField.text = dressCodeArray[dressIndex]
            O_CreateMainVC.createDict[APIKeys.kDressCode] = dressCodeArray[dressIndex]
            idIndex = idRequiredArray.firstIndex(of: EventVM.shared.eventDetailArray?[selectedIndex].idRequired ?? "") ?? 0
            idTextField.text = idRequiredArray[idIndex]
            O_CreateMainVC.createDict[APIKeys.kIdRequired] = idRequiredArray[idIndex]
            ageTextField.text = "\(EventVM.shared.eventDetailArray?[selectedIndex].ageRestrictions ?? 0)"
        }
        if type == .publicCategory {
            selectedPublicArray = array
            var publicArray = [String]()
            for data in CommonVM.shared.publicArray {
                if array.contains(data.id) {
                    publicArray.append(data.name)
                }
            }
            let idArray = CommonVM.shared.publicArray.map{$0.id}.filter(array.contains)
            let stringIdArray = idArray.map{(String($0))}
            O_CreateMainVC.createDict[APIKeys.kPublicInterest] = stringIdArray.joined(separator: ",")
            categoriesTextField.text = publicArray.joined(separator: ", ")
        }
        else {
            selectedMusicArray = array
            var musicArray = [String]()
            for data in CommonVM.shared.musicArray {
                if array.contains(data.id) {
                    musicArray.append(data.name)
                }
            }
            let idArray = CommonVM.shared.musicArray.map{$0.id}.filter(array.contains)
            let stringIdArray = idArray.map{(String($0))}
            O_CreateMainVC.createDict[APIKeys.kMusicInterest] = stringIdArray.joined(separator: ",")
            musicTextField.text = musicArray.joined(separator: ", ")
        }
        setupTextField()
    }
    private func setupTextField() {
        descriptionTextView.text! == kEventDescription ? backView.removeShadow(): backView.setShadow()
        descriptionTextView.text! == kEventDescription ? backView.addBackground(): backView.removeBackground()
        textFieldValue(textField: ageTextField)
        textFieldValue(textField: categoriesTextField)
        textFieldValue(textField: musicTextField)
        textFieldValue(textField: idTextField)
        textFieldValue(textField: dressCodeTextField)
        self.pickerDelegate = self
    }
    
    private func textFieldValue(textField: TextField) {
        textField.text!.count > 0 ? textField.setShadow(): textField.removeShadow()
        textField.text!.count > 0 ? textField.removeBackground(): textField.addBackground()
    }
    
    //MARK: IBActions
    @IBAction func addImageAction(_ sender: UIButton) {
        CustomImagePickerView.sharedInstace.delegate = self
        showImagePicker()
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        if isUpdate {
            let viewMotivVC = self.storyboard?.instantiateViewController(withIdentifier: kViewMotivVC) as! ViewMotivVC
            viewMotivVC.selectedIndex = self.selectedIndex
            viewMotivVC.isUpdate = self.isUpdate
            self.navigationController?.show(viewMotivVC, sender: self)
        } else {
            delegate.didClickTab(tag: 6)
        }
    }
    
    //MARK: Textfield Actions
    @IBAction func textFieldDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.text!.count > 0 ? sender.removeBackground(): sender.addBackground()
    }
}

//MARK: Textview Delegates
extension AddDetailsVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        backView.removeShadow()
        backView.addBackground()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.isEmpty ? kEventDescription: textView.text!
        textView.text!.count > 0 ? backView.setShadow(): backView.removeShadow()
        textView.text!.count > 0 ? backView.removeBackground(): backView.addBackground()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text!.count > 0 ? backView.setShadow(): backView.removeShadow()
        textView.text!.count > 0 ? backView.removeBackground(): backView.addBackground()
    }
}

//MARK: Textfield Delegates
extension AddDetailsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == categoriesTextField || textField == musicTextField {
            self.view.endEditing(true)
            let subcatvc = self.storyboard?.instantiateViewController(withIdentifier: kAddCategoryVC) as! AddCategoryVC
            subcatvc.modalPresentationStyle = .overCurrentContext
            subcatvc.delegate = self
            subcatvc.categoryArray = textField == musicTextField ? CommonVM.shared.musicArray: CommonVM.shared.publicArray
            subcatvc.selectedArray = textField == musicTextField ? selectedMusicArray: selectedPublicArray
            subcatvc.type = textField == musicTextField ? .musicCategory: .publicCategory
            self.navigationController?.present(subcatvc, animated: true, completion: nil)
        }
        else if textField == dressCodeTextField {
            setPicker(textField: textField, array: dressCodeArray, defaultIndex: dressIndex)
            dressCodeTextField.text = dressCodeArray[dressIndex]
            O_CreateMainVC.createDict[APIKeys.kDressCode] = dressCodeArray[dressIndex]
        }
        else if textField == idTextField {
            setPicker(textField: textField, array: idRequiredArray, defaultIndex: idIndex)
            idTextField.text = idRequiredArray[idIndex]
            O_CreateMainVC.createDict[APIKeys.kIdRequired] = idRequiredArray[idIndex]
        }
        selectedTextField = textField as! TextField
        setupTextField()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == ageTextField {
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 2
        }
        return true
    }
}

//MARK: Picker view Delegate
extension AddDetailsVC: PickerDelegate {
    
    func didSelectPickerViewAtIndex(index: Int) {
        if selectedTextField == dressCodeTextField {
            dressCodeTextField.text = dressCodeArray[index]
            dressIndex = index
            O_CreateMainVC.createDict[APIKeys.kDressCode] = dressCodeArray[dressIndex]
        }
        else if selectedTextField == idTextField {
            idTextField.text = idRequiredArray[index]
            idIndex = index
            O_CreateMainVC.createDict[APIKeys.kIdRequired] = idRequiredArray[idIndex]
        }
        setupTextField()
    }
}

//MARK: Category Delegate
extension AddDetailsVC: CategoryDelegate {
    
    func didGetCategories(array: [Int], type: CategoryType) {
        if type == .publicCategory {
            selectedPublicArray = array
            var publicArray = [String]()
            for data in CommonVM.shared.publicArray {
                if array.contains(data.id) {
                    publicArray.append(data.name)
                }
            }
            let idArray = CommonVM.shared.publicArray.map{$0.id}.filter(array.contains)
            let stringIdArray = idArray.map{(String($0))}
            O_CreateMainVC.createDict[APIKeys.kPublicInterest] = stringIdArray.joined(separator: ",")
            categoriesTextField.text = publicArray.joined(separator: ", ")
        }
        else {
            selectedMusicArray = array
            var musicArray = [String]()
            for data in CommonVM.shared.musicArray {
                if array.contains(data.id) {
                    musicArray.append(data.name)
                }
            }
            let idArray = CommonVM.shared.musicArray.map{$0.id}.filter(array.contains)
            let stringIdArray = idArray.map{(String($0))}
            O_CreateMainVC.createDict[APIKeys.kMusicInterest] = stringIdArray.joined(separator: ",")
            musicTextField.text = musicArray.joined(separator: ", ")
        }
        setupTextField()
    }
}

//MARK: Image Picker Delegate
extension AddDetailsVC: CustomImagePickerDelegate {
    
    func didImagePickerFinishPicking(_ image: UIImage) {
        backgroundImageView.image = image
        O_CreateMainVC.imageDict[APIKeys.kEventTheme] = image.imageData
    }
}

//MARK: Validations
extension AddDetailsVC {
    func validateData() -> String? {
        if categoriesTextField.text!.count == 0 {
            return kPublicValidation
        }
        if dressCodeTextField.text!.count == 0 {
            return kDressCodeValidation
        }
        if idTextField.text!.count == 0 {
            return kIdValidation
        }
        if descriptionTextView.text == kEventDescription {
            return kEventDescriptionValidation
        }
        O_CreateMainVC.createDict[APIKeys.kAgeRestrictions] = ageTextField.text!
        O_CreateMainVC.createDict[APIKeys.kEventDetail] = descriptionTextView.text!
        return nil
    }
}

//MARK: API Methods
extension AddDetailsVC {
    
    func getPublicInterest() {
        CommonVM.shared.getPublicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.getMusicInterest()
            }
        }
    }
    
    func getMusicInterest() {
        CommonVM.shared.getMusicInterest { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            } else {
                if self.isUpdate {
                    if let selectedPublicCategory = EventVM.shared.eventDetailArray?[self.selectedIndex].publicCategories.map({$0.id ?? 0}) {
                        self.setCategoryForUpdate(array: selectedPublicCategory, type: .publicCategory)
                    }
                    if let selectedMusicCategory = EventVM.shared.eventDetailArray?[self.selectedIndex].musicCategories.map({$0.id ?? 0}) {
                        self.setCategoryForUpdate(array: selectedMusicCategory, type: .musicCategory)
                    }
                }
            }
        }
    }
}
