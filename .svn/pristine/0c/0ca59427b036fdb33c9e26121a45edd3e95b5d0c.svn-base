//
//  U_TabbarVC.swift
//  MoTiv
//
//  Created by IOS on 08/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class U_TabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundImage = UIImage()
        self.selectedIndex = 0
        tabBar.clipsToBounds = true
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: view.frame.size.height - 65, width: view.frame.size.width, height: 1)
        topBorder.backgroundColor = UIColor.motivColor.darkBaseColor.color().cgColor
        view.layer.addSublayer(topBorder)
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [U_TabbarVC.self])
        appearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.darkGray], for: .normal)
        appearance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .selected)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
