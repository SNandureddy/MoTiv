//
//  ChnagePasswordVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ChnagePasswordVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet var textFieldCollection: [TextField]!
    
    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kChangePassword)
        for textField in textFieldCollection {
            textField.set(radius: 14.0)
        }
        self.updateButton.setBackgroundImage(self.updateButton.graidentImage, for: .normal)
        self.updateButton.set(radius: 14.0)
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.rightImage = sender.text!.count > 0 ? #imageLiteral(resourceName: "passwordSelected"): #imageLiteral(resourceName: "passwordUnselected")
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        self.showAlert(title: kSuccess, message: kPasswordChangeAlert, cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
            self.logout()
        }
    }
}
