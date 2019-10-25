//
//  HelpVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//


import UIKit

class HelpVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var contactUsButton: UIButton!
    
    //MARLK: Class Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kHelp)
        setBackButton(image: #imageLiteral(resourceName: "backCross"))
        self.contactUsButton.setBackgroundImage(self.contactUsButton.graidentImage, for: .normal)
        self.contactUsButton.set(radius: 14.0)
    }
    
    //MARK: IBActions
    @IBAction func termConditionButtonAction(_ sender: Any) {
        let termsvc = self.storyboard?.instantiateViewController(withIdentifier: kTermConditionVC) as! TermConditionVC
        let nav = UINavigationController(rootViewController: termsvc)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func contactUsButtonAction(_ sender: Any) {
    }
}
