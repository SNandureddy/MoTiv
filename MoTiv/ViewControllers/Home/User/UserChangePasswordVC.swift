//
//  UserChangePasswordVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class UserChangePasswordVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var oldPasswordTextField: TextField!
    @IBOutlet weak var newPasswordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var updateButton: UIButton!
    // MARK: - Variables
    
    // MARK: - Class life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.customizeUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    // MARK: - Private functions
    private func customizeUI() {
        setTextFieldUI()
        updateButton.setBackgroundImage(updateButton.graidentImage, for: .normal)
        updateButton.set(radius: 14.0)
    }
    func setTextFieldUI(){
        oldPasswordTextField.set(radius: 14.0)
        newPasswordTextField.set(radius: 14.0)
        confirmPasswordTextField.set(radius: 14.0)
    }
    // MARK: - IBActions
    
    @IBAction func updateButtonAction(_ sender: Any) {
        self.showAlert(title: kSuccess, message: kChangePasswordAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, nil)
    }
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        switch sender {
        case oldPasswordTextField:
             oldPasswordTextField.rightImage = oldPasswordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
            oldPasswordTextField.text!.count > 0 ? oldPasswordTextField.setShadow(): oldPasswordTextField.removeShadow()
            break
        case newPasswordTextField:
             newPasswordTextField.rightImage = newPasswordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
            newPasswordTextField.text!.count > 0 ? newPasswordTextField.setShadow(): newPasswordTextField.removeShadow()
            break
        case confirmPasswordTextField:
            confirmPasswordTextField.rightImage = confirmPasswordTextField.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected") : #imageLiteral(resourceName: "passwordUnselected")
            confirmPasswordTextField.text!.count > 0 ? confirmPasswordTextField.setShadow(): confirmPasswordTextField.removeShadow()
            break
        default:
            break
        }
    }
}
//MARK: UITextField Delegates
extension UserChangePasswordVC:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
