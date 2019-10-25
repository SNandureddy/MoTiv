//
//  OrganiserSignupVC.swift
//  MoTiv
//
//  Created by IOS on 26/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SDWebImage

class OrganiserSignupVC: BaseVC {
    
    //MARK: IBoutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: Variables
    var organiserSelectedImageArray = [#imageLiteral(resourceName: "userSelected"), #imageLiteral(resourceName: "userSelected"), #imageLiteral(resourceName: "mailSelected"), #imageLiteral(resourceName: "phoneSelected"), #imageLiteral(resourceName: "passwordSelected"), #imageLiteral(resourceName: "passwordSelected"), #imageLiteral(resourceName: "editSelected")]
    var organiserUnSelectedImageArray = [#imageLiteral(resourceName: "userUnselected"), #imageLiteral(resourceName: "userUnselected"), #imageLiteral(resourceName: "mailUnSelected"), #imageLiteral(resourceName: "phoneUnselected"), #imageLiteral(resourceName: "passwordUnselected"), #imageLiteral(resourceName: "passwordUnselected"), #imageLiteral(resourceName: "editUnselected")]
    var userData = [Int: String]()
    var userDict = JSONDictionary()
    var imageDict = [String: Data]()
    var signupDict = JSONDictionary()
    var enableEmail = true

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kSignup)
        submitButton.set(radius: 14.0)
        submitButton.setBackgroundImage(submitButton.graidentImage, for: .normal)
        userImageView.set(radius: userImageView.half)
    }
    
    private func setupData() {
        signupDict[APIKeys.kUserType] = 3
        if userDict.count > 0 {
            userImageView.sd_setImage(with: userDict[APIKeys.kImage] as? URL, placeholderImage: #imageLiteral(resourceName: "userImagePlaceholder"), options: .refreshCached, completed: nil)
            userData[0] = userDict[APIKeys.kName] as? String
            userData[2] = userDict[APIKeys.kEmail] as? String
            enableEmail = (userDict[APIKeys.kEmail] as? String ?? "").count == 0
            signupDict[APIKeys.kSignupType] = 2
            signupDict[APIKeys.kSocialId] = userDict[APIKeys.kId]
            signupDict[APIKeys.kSocialSignupType] = userDict[APIKeys.kSocialSignupType]
            return
        }
        signupDict[APIKeys.kSignupType] = 1
    }
    
    //MARK: IBActions
    @IBAction func addImageAction(_ sender: UIButton) {
        CustomImagePickerView.sharedInstace.delegate = self
        self.showImagePicker()
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if let dict = validateData() {
            signup(dict: dict)
        }
    }
}

//MARK: TableView Datasource
extension OrganiserSignupVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDict.count > 0 ? 5: 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTextFieldCell) as! TextFieldCell
        cell.titleLabel.text = organiserTitleArray[indexPath.row] //Set Title
        cell.textField.set(placholder: organiserPlaceholderArray[indexPath.row ]) //Set Placeholder
        
        //Customise UI
        cell.textField.set(radius: 14.0)
        
        //TextField Management
        cell.textField.text = userData[indexPath.row]
        cell.textField.rightImage = cell.textField.text!.count > 0 ? organiserSelectedImageArray[indexPath.row] : organiserUnSelectedImageArray[indexPath.row] //Set Right Image
        cell.textField.text!.count > 0 ? cell.textField.setShadow(): cell.textField.removeShadow()
        cell.textField.isUserInteractionEnabled = true
        //Add TextField Target
        cell.textField.tag = indexPath.row
        cell.textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        if indexPath.row == 0 {
            cell.textField.autocapitalizationType = .words
        }
        else {
            cell.textField.autocapitalizationType = .none
        }
        cell.textField.delegate = self

        //Setup Keyboard
        switch indexPath.row {
        case 2:
            cell.textField.isUserInteractionEnabled = enableEmail
            cell.textField.keyboardType = .emailAddress
            cell.textField.isSecureTextEntry = false
        case 3:
            cell.textField.keyboardType = .numberPad
            cell.textField.isSecureTextEntry = false
        case 4,5:
            cell.textField.keyboardType = .asciiCapable
            cell.textField.isSecureTextEntry = true
        default:
            cell.textField.keyboardType = .default
            cell.textField.isSecureTextEntry = false
        }
        
        //Setup Textview
        let lastRow = userDict.count > 0 ? 4: 6
        if indexPath.row == lastRow { //About You
            let cell = tableView.dequeueReusableCell(withIdentifier: kTextViewCell) as! TextViewCell
            cell.titleLabel.text = organiserTitleArray[6]
            cell.textView.tag = indexPath.row
            cell.textView.delegate = self
            cell.textView.text = userData[indexPath.row] != nil ? userData[indexPath.row]: kAboutYou
            cell.iconImageView.image = cell.textView.text! == kAboutYou ? organiserUnSelectedImageArray[6]: organiserSelectedImageArray[6]
            cell.backView.set(radius: 14.0)
            cell.textView.text == kAboutYou ? cell.backView.removeShadow(): cell.backView.setShadow()
            return cell
        }
        return cell
    }
    
    //MARK: TextField Actions
    @objc func textFieldDidChange(textField: TextField) {
        userData[textField.tag] = textField.text!
        textField.rightImage = textField.text!.count > 0 ? organiserSelectedImageArray[textField.tag] : organiserUnSelectedImageArray[textField.tag]
        textField.text!.count > 0 ? textField.setShadow(): textField.removeShadow()
    }
}

//MARK: TableView Delegates
extension OrganiserSignupVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let lastRow = userDict.count > 0 ? 4: 6
        if indexPath.row == lastRow {
            return 170
        }
        return 93
    }
}


extension OrganiserSignupVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 3 { //Phone Number
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= 14
        }
        else if textField.tag == 1 { //Username
            return !(string == " ")
        }
        return true
    }
}

//MARK: Textview Delegates
extension OrganiserSignupVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = textView.text! == kAboutYou ? "" :textView.text!
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text!.isEmpty ? kAboutYou: textView.text!
        if !textView.text!.isEmpty {
            userData[textView.tag] = textView.text!
        }
        let cell = tableView.cellForRow(at: IndexPath(row: textView.tag, section: 0)) as! TextViewCell
        cell.iconImageView.image = textView.text! == kAboutYou ? organiserUnSelectedImageArray[textView.tag]: organiserSelectedImageArray[textView.tag]
        textView.text! == kAboutYou ? cell.backView.removeShadow(): cell.backView.setShadow()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text!.isEmpty {
            userData[textView.tag] = textView.text!
        }
        let cell = tableView.cellForRow(at: IndexPath(row: textView.tag, section: 0)) as! TextViewCell
        cell.iconImageView.image = textView.text!.isEmpty ? organiserUnSelectedImageArray[textView.tag]: organiserSelectedImageArray[textView.tag]
        textView.text!.isEmpty ? cell.backView.removeShadow(): cell.backView.setShadow()
    }
}

//MARK: Imagepicket Delegate
extension OrganiserSignupVC: CustomImagePickerDelegate {
 
    func didImagePickerFinishPicking(_ image: UIImage) {
        userImageView.image = image
        userImageView.set(radius: userImageView.half)
        imageDict[APIKeys.kImage] = image.imageData
    }
}

//MARK: Validations
extension OrganiserSignupVC {
    
    func validateData() -> JSONDictionary? {
        if let name = userData[0], name.isValidData { //Valid Name
            signupDict[APIKeys.kFirstName] = name
        }
        else {
            self.showAlert(message: kNameValidation)
            return nil
        }
        if let userName = userData[1], userName.isValidData { //Valid Username
            signupDict[APIKeys.kUserName] = userName
        }
        else {
            self.showAlert(message: kUserNameValidation)
            return nil
        }
        if let email = userData[2], email.isValidEmail { //Valid Email
            signupDict[APIKeys.kEmail] = email
        }
        else {
            self.showAlert(message: kEmailValidation)
            return nil
        }
        if let phoneNumber = userData[3], phoneNumber.count == 0 || phoneNumber.isValidPhone { //Valid Phone Number
            signupDict[APIKeys.kPhoneNumber] = phoneNumber
        }
        else {
            self.showAlert(message: kPhoneValidation)
            return nil
        }
        if userDict.count == 0 {
            if let password = userData[4], password.isValidPassword { //Valid Password
                signupDict[APIKeys.kPassword] = password
            }
            else {
                self.showAlert(message: kPasswordValidation)
                return nil
            }
            if let password = userData[5], password == userData[4] ?? "" { //Valid Confirm Password
            }
            else {
                self.showAlert(message: kConfirmPasswordValidation)
                return nil
            }
        }
        else {
            if imageDict.count == 0 {
                signupDict[APIKeys.kImage] = (userDict[APIKeys.kImage] as? URL)?.absoluteString
            }
        }
        signupDict[APIKeys.kAboutMe] = userDict.count == 0 ? userData[6]: userData[4]
        return signupDict
    }
}

//MARK: API Methods
extension OrganiserSignupVC {
    
    func signup(dict: JSONDictionary) {
        UserVM.shared.signup(userDetails: dict, imageDict: imageDict) { (messsage, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.showAlert(title: kSuccess, message: self.userDict.count > 0 ? kSocialSignupSuccess: kSignupAlert, cancelTitle: self.userDict.count > 0 ? nil: kCancel, cancelAction: {
                    self.navigationController?.popToRootViewController(animated: true)
                }, okayTitle: self.userDict.count > 0 ? kOkay: kOpenMail) {
                    if self.userDict.count > 0 {
                        BaseVC.userType = .organiser
                    }
                    else {
                        self.logout()
                    }
                    self.userDict.count > 0 ? self.navigateToHome(): self.openMail()
                }
            }
        }
    }
}
