//
//  ReferalCodeVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class ReferalCodeVC: BaseVC {
    
     //MARK:- IBOutlet
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var referalCodeLabel: UILabel!
    
    //MARK: Variables
    var isFromProfile = false
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
  
    override func rightButtonAction(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kWelcomeVC ) as! WelcomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Private func
    func customUI(){
        if !isFromProfile {
            setRightButton(title: kSkip)
            setTitle(title: "", showBack: isFromProfile)
        }
        else {
            setTitle(title: "REFERRAL CODE")
        }
        self.shareButton.setBackgroundImage(shareButton.graidentImage, for: .normal)
        self.shareButton.set(radius: 14.0)
    }
    
    
    //MARK:- IBAction
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func privacyPolicyButtonAction(_ sender: Any) {
    }
    
}
