//
//  EmailVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class EmailVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var EmailTextFIeld: TextField!
    
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
        EmailTextFIeld.set(radius: 14.0)
        setupTextField()
    }
    
    private func setupData() {
        EmailTextFIeld.text = SignupContainerVC.userDict[APIKeys.kEmail] as? String
        SignupContainerVC.signupDict[APIKeys.kEmail] = EmailTextFIeld.text!
        EmailTextFIeld.isUserInteractionEnabled = !(EmailTextFIeld.text!.count > 0)
    }
    
    private func setupTextField() {
        EmailTextFIeld.rightImage = EmailTextFIeld.text!.count > 0 ? #imageLiteral(resourceName: "mailSelected") : #imageLiteral(resourceName: "mailUnSelected")
        EmailTextFIeld.text!.count > 0 ? EmailTextFIeld.setShadow(): EmailTextFIeld.removeShadow()
    }

    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        setupTextField()
        SignupContainerVC.signupDict[APIKeys.kEmail] = sender.text!
    }
}
