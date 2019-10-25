//
//  AddNameVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class AddNameVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Variables
    var delegate: TabViewDelegate!
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
        nameTextField.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setupTextField()
    }
    
    func setUpdateEvent() {
        if isUpdate {
            nameTextField.text = EventVM.shared.eventDetailArray?[selectedIndex].eventName ?? ""
        }
    }
    private func setupTextField() {
        nameTextField.text!.count > 0 ? nameTextField.removeBackground(): nameTextField.addBackground()
        nameTextField.text!.count > 0 ? nameTextField.setShadow(): nameTextField.removeShadow()
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        O_CreateMainVC.createDict[APIKeys.kEventName] = nameTextField.text!
        delegate.didClickTab(tag: 3)
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: TextField) {
        setupTextField()
    }
}

//MARK: Validations
extension AddNameVC {
    
    func validateData() -> String? {
        if !nameTextField.isValidName {
            return kEventNameValidation
        }
        return nil
    }
}
