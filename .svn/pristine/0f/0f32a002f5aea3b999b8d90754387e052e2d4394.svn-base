//
//  UsernameVC.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class UsernameVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var userNameTextField: TextField!
    
    //MARK: View Controller Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        userNameTextField.delegate = self
        userNameTextField.set(radius: 14.0)
        setupTextField()
    }

    private func setupTextField() {
        userNameTextField.rightImage = userNameTextField.text!.count > 0 ? #imageLiteral(resourceName: "userImageIcon") : #imageLiteral(resourceName: "userUnselected")
        userNameTextField.text!.count > 0 ? userNameTextField.setShadow(): userNameTextField.removeShadow()
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        setupTextField()
        SignupContainerVC.signupDict[APIKeys.kUserName] = sender.text!
    }
}

extension UsernameVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !(string == " ")
    }
}

