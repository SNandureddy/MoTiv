//
//  SettingVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//


import UIKit

class SettingVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kSettings)
        changePasswordButton.set(radius: 14.0)
        logoutButton.set(radius: 14.0)
        changePasswordButton.setShadow()
        logoutButton.setShadow()
    }
    
    //MARK: IBAction
    @IBAction func changePasswordButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        self.showAlert(title: nil, message: kLogoutAlert, cancelTitle: kCancel, cancelAction: nil, okayTitle: kYes) {
            self.logout()
        }
    }
    
}
