//
//  dateOfBirthVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class dateOfBirthVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var PhoneNumberTextField: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var referralCodeTextField: TextField!
    
    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pickerDelegate = self
        self.setDatePicker(textField: dateOfBirthTextField, mode: .date, maxdate: Date().addYearsInDate(years: -16))
        customiseUI()
    }
   
    //MARK: Private Methods
    private func customiseUI(){
        PhoneNumberTextField.delegate = self
        PhoneNumberTextField.set(radius: 14.0)
        dateOfBirthTextField.set(radius: 14.0)
        referralCodeTextField.set(radius: 14.0)
        setupTextField()
    }
    
    private func setupTextField() {
        
        PhoneNumberTextField.text!.count > 0 ? PhoneNumberTextField.setShadow(): PhoneNumberTextField.removeShadow()
        PhoneNumberTextField.text!.count > 0 ?   PhoneNumberTextField.removeBackground() : PhoneNumberTextField.addBackground()
        dateOfBirthTextField.text!.count > 0 ? dateOfBirthTextField.setShadow(): dateOfBirthTextField.removeShadow()
        dateOfBirthTextField.text!.count > 0 ?   dateOfBirthTextField.removeBackground() : dateOfBirthTextField.addBackground()
        referralCodeTextField.text!.count > 0 ? referralCodeTextField.setShadow(): referralCodeTextField.removeShadow()
        referralCodeTextField.text!.count > 0 ?   referralCodeTextField.removeBackground() : referralCodeTextField.addBackground()
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: TextField) {
        setupTextField()
        if sender == PhoneNumberTextField {
            SignupContainerVC.signupDict[APIKeys.kPhoneNumber] = sender.text!
        }
        if sender == referralCodeTextField {
            SignupContainerVC.signupDict[APIKeys.kReferralCode] = referralCodeTextField.text!
        }
    }
}

//MARK: Custom Picker Delegates
extension dateOfBirthVC: PickerDelegate {
    
    func didSelectDatePicker(date: Date) {
        dateOfBirthTextField.text = date.stringFromDate(format: .mdyDate, type: .local)
        SignupContainerVC.signupDict[APIKeys.kAge] = dateOfBirthTextField.text!
        setupTextField()
    }
}

//MARK: Textfield Delegates
extension dateOfBirthVC: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= 14
    }
}
