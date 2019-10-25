//
//  DescriptionVC.swift
//  MoTiv
//
//  Created by IOS on 08/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class DescriptionVC: BaseVC {

    //MARK: IBOutlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Variables
    var delegate: TabViewDelegate!
    var isUpdate = false
    var selectedIndex = Int()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        baseView.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
        setupTextField()
    }
    
    private func setupTextField() {
        descriptionTextView.text! == kEnterEventDescription ? baseView.removeShadow(): baseView.setShadow()
        descriptionTextView.text! == kEnterEventDescription ? baseView.addBackground(): baseView.removeBackground()
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        delegate.didClickTab(tag: 6)
    }
}

//MARK: Textview Delegates
extension DescriptionVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        setupTextField()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.isEmpty ? kEnterEventDescription: textView.text!
        setupTextField()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        setupTextField()
    }
}

//MARK: Validations
extension DescriptionVC {
    
    func validateData() -> String? {
        if descriptionTextView.text! == kEnterEventDescription {
            return kEventDescriptionValidation
        }
        O_CreateMainVC.createDict[APIKeys.kEventDetail] = descriptionTextView.text!
        return nil
    }
}
