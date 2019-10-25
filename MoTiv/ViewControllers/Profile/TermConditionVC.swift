//
//  TermConditionVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//


import UIKit

class TermConditionVC: BaseVC {

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
        setTitle(title: kTerms)
        setBackButton(image: #imageLiteral(resourceName: "backCross"))
    }
}
