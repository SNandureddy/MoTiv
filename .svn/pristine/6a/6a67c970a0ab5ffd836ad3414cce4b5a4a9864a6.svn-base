//
//  WelcomeVC.swift
//  MoTiv
//
//  Created by ios2 on 03/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class WelcomeVC: BaseVC {
    
      //MARK: - IBOutlet
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
      //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK: - Private Func
    fileprivate func customUI(){
        self.setTitle(title: " ", showBack: false)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.skipButton.setBackgroundImage(skipButton.graidentImage, for: .normal)
        self.skipButton.set(radius: 14.0)
    }
    
      //MARK: - IBAction
    @IBAction func facebookButtonAction(_ sender: Any) {
    }
    
    @IBAction func twitterButtonAction(_ sender: Any) {
    }
    
    @IBAction func instagramButtonAction(_ sender: Any) {
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        DataManager.isFirstTime = true
         self.navigateToHome()
    }
}
