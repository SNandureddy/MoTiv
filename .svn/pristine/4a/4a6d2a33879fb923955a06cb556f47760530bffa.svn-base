//
//  PasswordVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class PasswordVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var signupButton: UIButton!
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        customiseUI()
    }
   
    //MARK:  Private Methods
    private func customiseUI(){
        setTitle(title: kSignup)
        passwordTextField.set(radius: 14.0)
        confirmPasswordTextField.set(radius: 14.0)
        self.signupButton.setBackgroundImage(signupButton.graidentImage, for: .normal)
        self.signupButton.set(radius: 14.0)
        setupTextField()
    }
    
    private func setupTextField() {
        passwordTextField.rightImage = passwordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
        passwordTextField.text!.count > 0 ? passwordTextField.setShadow(): passwordTextField.removeShadow()
        confirmPasswordTextField.rightImage = confirmPasswordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
        confirmPasswordTextField.text!.count > 0 ? confirmPasswordTextField.setShadow(): confirmPasswordTextField.removeShadow()
    }
    
    private func navigateToAbout() {
        SignupContainerVC.signupDict[APIKeys.kPassword] = passwordTextField.text!
        self.showAlert(title: kSuccess, message: kSignUpAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: kAboutYouVC) as! AboutYouVC
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    //MARK: IBActions
    @IBAction func signUpButtonAction(_ sender: Any) {
        if let message = self.validateData() {
            self.showAlert(message: message)
            return
        }
        navigateToAbout()
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        setupTextField()
    }
}

//MARK: Validate Data
extension PasswordVC {
    
    func validateData() -> String? {
        if !passwordTextField.isValidPassword {
            return kPasswordValidation
        }
        if passwordTextField.text! != confirmPasswordTextField.text! {
            return kConfirmPasswordValidation
        }
        return nil
    }
}

