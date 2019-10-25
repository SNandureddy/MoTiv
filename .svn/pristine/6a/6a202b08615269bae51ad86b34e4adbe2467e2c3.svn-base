//
//  NameVC.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class NameVC: BaseVC {
    
    //IBOutlet
    @IBOutlet weak var firstNameTextField: TextField!
    @IBOutlet weak var lastnameTextField: TextField!
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        customiseUI()
    }
   
    //MARK: Private Methods
    private func customiseUI(){
        firstNameTextField.set(radius: 14.0)
        lastnameTextField.set(radius: 14.0)
        setupTextField()
    }
    
    private func setupTextField() {
        firstNameTextField.rightImage = firstNameTextField.text!.count > 0 ? #imageLiteral(resourceName: "userImageIcon") : #imageLiteral(resourceName: "userUnselected")
        firstNameTextField.text!.count > 0 ? firstNameTextField.setShadow(): firstNameTextField.removeShadow()
        lastnameTextField.rightImage = lastnameTextField.text!.count > 0 ?  #imageLiteral(resourceName: "userImageIcon") : #imageLiteral(resourceName: "userUnselected")
        lastnameTextField.text!.count > 0 ? lastnameTextField.setShadow(): lastnameTextField.removeShadow()
    }
    
    private func setupData() {
        firstNameTextField.text = SignupContainerVC.userDict[APIKeys.kName] as? String
        SignupContainerVC.signupDict[APIKeys.kFirstName] = firstNameTextField.text!
    }
   
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: TextField) {
        setupTextField()
        if sender == firstNameTextField {
            SignupContainerVC.signupDict[APIKeys.kFirstName] = sender.text!
        }
        if sender == lastnameTextField {
            SignupContainerVC.signupDict[APIKeys.kLastName] = sender.text!
        }
    }
}


