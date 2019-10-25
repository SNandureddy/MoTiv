//
//  LoginVC.swift
//  MoTiv
//
//  Created by Apple on 17/09/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import Alamofire
class LoginVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        hideNavigationBar()
        emailTextField.set(radius: 14.0)
        passwordTextField.set(radius: 14.0)
        loginButton.set(radius: 14.0)
        loginButton.setBackgroundImage(loginButton.graidentImage, for: .normal)
    }

    //MARK: IBActions
    @IBAction func loginButtonAction(_ sender: UIButton) { //1: With Credentials 2: Without Login
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.isUserInteractionEnabled = true
        }
        if sender.tag == 1 {
            if let message = validateData() {
                self.showAlert(message: message)
                return
            }
            loginWithEmail()
        }
        else {
            DataManager.isLoggedIn = false
            BaseVC.userType = .user
            self.navigateToHome()
        }
    }
    
    @IBAction func socialButtonAction(_ sender: UIButton) { //3: Facebook 4: Twitter 5: Instagram
        if (appDelegate.net?.isReachable)! {
            switch sender.tag {
            case 3:
                loginWithFb()
                break
            case 4: //Twitter
                self.loginWithTwitter()
                break
            default: //Instagram
                InstagramLoginSuite.shared.delegate = self
                InstagramLoginSuite.shared.login(baseView: self.view)
                break
            }
        } else {
            showAlert(message: "Your internet connection appears to be offline. Please try again.")
        }
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            emailTextField.rightImage = emailTextField.text!.count > 0 ? #imageLiteral(resourceName: "mailSelected") : #imageLiteral(resourceName: "mailUnSelected")
            emailTextField.text!.count > 0 ? emailTextField.setShadow(): emailTextField.removeShadow()
            break
        case passwordTextField:
            passwordTextField.rightImage = passwordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
            passwordTextField.text!.count > 0 ? passwordTextField.setShadow(): passwordTextField.removeShadow()
            break
        default:
            break
        }
    }
}

extension LoginVC {
    
    func validateData() -> String? {
        if !emailTextField.isValidEmail {
            return kEmailValidation
        }
        if !passwordTextField.isValidPassword {
            return kPasswordValidation
        }
        return nil
    }
    
}

extension LoginVC: InstaDelegate {
    
    func successWithLogin(user: InstaUser?) {
        if user != nil {
            self.socialLogin(id: user!.id, type: kInstagram, userDict: user!.jsonDict)
        }
    }
}


extension LoginVC {
    
    func loginWithTwitter() {
        TwitterLoginSuite.shared.login { (user, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.socialLogin(id: user!.id, type: kTwitter, userDict: user!.jsonDict)
            }
        }
    }
    
    func loginWithFb() {
        let fbSuite = FacebookLoginSuite()
        fbSuite.logout()
        fbSuite.signInWithController(controller: self, success: { (success, response) in
            let dict = self.parseFBData(response: response as! JSONDictionary)
            let socialID = dict[APIKeys.kId] as! String
            Indicator.sharedInstance.hideIndicator()
            self.socialLogin(id: socialID, type: kFacebook, userDict: dict)
        }) { (errorReason, error) in
            Indicator.sharedInstance.hideIndicator()
        }
    }
    
    func socialLogin(id: String, type: String, userDict: JSONDictionary) {
        UserVM.shared.socialLogin(id: id, type: type) { (message, error) in
            if error != nil {
                let signupvc = self.storyboard?.instantiateViewController(withIdentifier: kSelectUserTypeVC) as! SelectUserTypeVC
                signupvc.userDict = userDict
                self.navigationController?.show(signupvc, sender: self)
            }
            else {
                print(kSuccess)
                self.navigateToHome()
            }
        }
    }
    
    func loginWithEmail() {
        UserVM.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }
            else {
                self.navigateToHome()
            }
        }
    }
}
