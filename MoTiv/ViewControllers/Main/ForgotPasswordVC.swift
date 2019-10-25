//
//  ForgotPasswordVC.swift
//  MoTiv
//
//  Created by IOS on 26/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ForgotPasswordVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var sendButton: UIButton!
    
    //MARK: Class
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK Private Methods
    private func customiseUI() {
        setTitle(title: kForgotPassword)
        emailTextField.set(radius: 14.0)
        sendButton.set(radius: 14.0)
        sendButton.setBackgroundImage(sendButton.graidentImage, for: .normal)

    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        emailTextField.rightImage = emailTextField.text!.count > 0 ? #imageLiteral(resourceName: "mailSelected") : #imageLiteral(resourceName: "mailUnSelected")
        emailTextField.text!.count > 0 ? emailTextField.setShadow(): emailTextField.removeShadow()
    }
    
    //MARK: IBActions
    @IBAction func sendButtonAction(_ sender: UIButton) {
        if let message = self.validateData() {
            self.showAlert(message: message)
            return
        }
        forgotPassword()
    }
}

//MARK: Validations
extension ForgotPasswordVC {
    
    func validateData() -> String? {
        if !emailTextField.isValidEmail {
            return kEmailValidation
        }
        return nil
    }
}

//MARK: API Methods
extension ForgotPasswordVC {
    
    func forgotPassword() {
        UserVM.shared.forgotPassword(email: emailTextField.text!) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.showAlert(title: kSuccess, message: kForgotAlert, cancelTitle: kCancel, cancelAction: {
                    self.navigationController?.popViewController(animated: true)
                }, okayTitle: kOpenEmail) {
                    self.openMail()
                }
            }
        }
    }
}
