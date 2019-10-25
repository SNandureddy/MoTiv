//
//  ContactUsVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ContactUsVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var subjectTextField: TextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    func customiseUI() {
        setTitle(title: kContactus)
        subjectTextField.set(radius: 14.0)
        baseView.set(radius: 14.0)
        self.submitButton.setBackgroundImage(self.submitButton.graidentImage, for: .normal)
        self.submitButton.set(radius: 14.0)
    }
    
    //MARK: IBActions
    @IBAction func submitButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "penSelected"): #imageLiteral(resourceName: "penUnSelected")
    }
}

extension ContactUsVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        baseView.removeShadow()
        iconImageView.image = #imageLiteral(resourceName: "commentUnSelected")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text!.count > 0 ? baseView.setShadow(): baseView.removeShadow()
        iconImageView.image = textView.text!.count > 0 ? #imageLiteral(resourceName: "commentSelected"): #imageLiteral(resourceName: "commentUnSelected")
        textView.text = textView.text!.isEmpty ? kContactDescription: textView.text!
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text!.count > 0 ? baseView.setShadow(): baseView.removeShadow()
        iconImageView.image = textView.text!.count > 0 ? #imageLiteral(resourceName: "commentSelected"): #imageLiteral(resourceName: "commentUnSelected")
    }
}

