//
//  createGuestListVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//


import UIKit

class createGuestListVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var GuestListNameTextField: TextField!
    @IBOutlet weak var createButton: UIButton!

    //MARK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Variables
    var selectedIndex = Int()
    
    //MARK: Private Methods
    private func customiseUI(){
        self.setTitle(title: kCreatGuestList)
        self.createButton.setBackgroundImage(createButton.graidentImage, for: .normal)
        self.createButton.set(radius: 14.0)
        GuestListNameTextField.set(radius: 14.0)
        GuestListNameTextField.text!.count > 0 ? GuestListNameTextField.setShadow(): GuestListNameTextField.removeShadow()
    }
    
    @IBAction func createButtonAction(_ sender: UIButton) {
        if (GuestListNameTextField.text?.count ?? 0) < 2 {
            showAlert(message: kNameValidation)
            return
        }
        let addGuestvc = self.storyboard?.instantiateViewController(withIdentifier: kAddGuestVC) as! AddGuestVC
        addGuestvc.selectedIndex = self.selectedIndex
        addGuestvc.guestListName = self.GuestListNameTextField.text ?? ""
        addGuestvc.guestListType = .new
        self.navigationController?.show(addGuestvc, sender: self)
    }
    
    @IBAction func textDidChange(_ sender: TextField) {
        if sender.text == " " {
            sender.text = ""
            return
        }
        sender.text!.count > 0 ? sender.setShadow(): sender.removeShadow()
        sender.text!.count > 0 ? sender.removeBackground(): sender.addBackground()
    }
}

