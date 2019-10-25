//
//  SettingsVC.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SettingsVC: BaseVC {
    
    //MARK:- IBOutlet
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var displayAgeButton: UIButton!
    @IBOutlet weak var enableNotificationButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK:- Private func
    fileprivate func customUI(){
        setTitle(title: kSettings)
        self.changePasswordButton.set(radius: 14.0)
        self.changePasswordButton.setShadow()
        self.displayAgeButton.set(radius: 14.0)
        self.displayAgeButton.setShadow()
        self.enableNotificationButton.set(radius: 14.0)
        self.enableNotificationButton.setShadow()
        self.notificationsButton.set(radius: 14.0)
        self.notificationsButton.setShadow()
        self.logoutButton.set(radius: 14.0)
        self.logoutButton.setShadow()
    }
    
    //MARK:- IBAction
    @IBAction func changePasswordAction(_ sender: Any) {
//        let storyboard = UIStoryboard.init(storyboard: .Profile)
//        let vc = storyboard.instantiateViewController(withIdentifier: kChnagePasswordVC) as! ChnagePasswordVC
//        self.navigationController?.show(vc, sender: self)
    }
    
    @IBAction func displayAgeOnProfileSwitchAction(_ sender: UISwitch) {
        
    }
    
    @IBAction func enableNotificationSwitchAction(_ sender: UISwitch) {
        
    }
    
    @IBAction func notificationsAction(_ sender: Any) {
        
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.showAlert(title: nil, message: kLogoutAlert, cancelTitle: kCancel, cancelAction: nil, okayTitle: kYes, {
            self.logout()
        })
    }
    
    
}
