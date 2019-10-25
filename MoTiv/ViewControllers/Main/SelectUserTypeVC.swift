//
//  SelectUserTypeVC.swift
//  MoTiv
//
//  Created by IOS on 26/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SelectUserTypeVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var signupButton: UIButton!
    var userDict = JSONDictionary()
    
    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        setTitle(title: kSelectUserType)
        signupButton.set(radius: 14.0)
        signupButton.setBackgroundImage(signupButton.graidentImage, for: .normal)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OrganiserSignupVC {
            destination.userDict = userDict
        }
        SignupContainerVC.userDict = userDict
    }
}
