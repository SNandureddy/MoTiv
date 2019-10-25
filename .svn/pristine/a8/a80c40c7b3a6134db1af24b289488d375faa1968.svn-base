//
//  CreateTicketVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class CreateTicketVC: BaseVC {
    
    //MARK: IBoutlets
    @IBOutlet weak var titleTextField: TextField!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var amountTextField: TextField!
    @IBOutlet weak var quantityTextField: TextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: Variables
    var delegate: TicketDelegate!
    var ticket = JSONDictionary()
    
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
        setTitle(title: kAddTicket)
        titleTextField.set(radius: 14.0)
        backView.set(radius: 14.0)
        amountTextField.set(radius: 14.0)
        quantityTextField.set(radius: 14.0)
        saveButton.set(radius: 14.0)
        saveButton.setBackgroundImage(saveButton.graidentImage, for: .normal)
    }
    
    //MARK: IBActions
    @IBAction func saveButtonAction(_ sender: UIButton) {
        if let message = self.validateData() {
            self.showAlert(message: message)
            return
        }
        delegate.didCreateTicket(ticket: ticket)
        self.backButtonAction()
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.text!.count > 0 ? sender.removeBackground(): sender.addBackground()
    }
}

//MARK: Textview Delegates
extension CreateTicketVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        backView.removeShadow()
        backView.addBackground()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text!.count > 0 ? backView.setShadow(): backView.removeShadow()
        textView.text!.count > 0 ? backView.removeBackground(): backView.addBackground()
        textView.text = textView.text.isEmpty ? kTicketDescription: textView.text!
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text!.count > 0 ? backView.setShadow(): backView.removeShadow()
        textView.text!.count > 0 ? backView.removeBackground(): backView.addBackground()
    }
}

//MARK: Validations
extension CreateTicketVC {
    
    func validateData() -> String? {
        if !titleTextField.isValidName {
            return kTicketNameValidation
        }
        if !descriptionTextView.text!.isValidData {
            return kTicketDetailsVC
        }
        if amountTextField.isEmpty {
            return kTicketAmountValidation
        }
        if quantityTextField.isEmpty {
            return kTicketQuantityValidation
        }
        ticket[APIKeys.kTicketTitle] = titleTextField.text
        ticket[APIKeys.kTicketDescription] = descriptionTextView.text
        ticket[APIKeys.kTicketAmount] = amountTextField.text
        ticket[APIKeys.kTicketQuantity] = quantityTextField.text
        return nil
    }
}
