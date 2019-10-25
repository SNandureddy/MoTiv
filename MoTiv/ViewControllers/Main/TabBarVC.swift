//
//  TabBarVC.swift
//  MoTiv
//
//  Created by IOS on 27/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundImage = UIImage()
        self.selectedIndex = 0
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: view.frame.size.height - 65, width: view.frame.size.width, height: 1)
        topBorder.backgroundColor = UIColor.motivColor.darkBaseColor.color().cgColor
        view.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
        let appearance = UITabBarItem.appearance(whenContainedInInstancesOf: [TabBarVC.self])
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


class CustomTabBar : UITabBar {
    @IBInspectable var height: CGFloat = 50.0
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if height > 0.0 {
            sizeThatFits.height = height
        }
        return sizeThatFits
    }
}
