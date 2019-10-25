//
//  PromotionPackageVC.swift
//  MoTiv
//
//  Created by ios2 on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//
import UIKit

class PromotionPackageVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var greenTickButtonFIrst: UIImageView!
    @IBOutlet weak var greenTickButtonSecond: UIImageView!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet var backViewCollection: [UIView]!
    
    
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
        for view in backViewCollection {
            view.set(radius: 20.0)
            view.setShadow()
        }
        setTitle(title: kPromotionPackages)
        purchaseButton.setBackgroundImage(self.purchaseButton.graidentImage, for: .normal)
        purchaseButton.set(radius: 14.0)
    }
    
    //MARK: IBActions
    @IBAction func selectPromotionAction(_ sender: UIButton) {
        if sender.tag == 1 {
            greenTickButtonFIrst.isHidden = false
            greenTickButtonSecond.isHidden = true
        }
        else {
            greenTickButtonFIrst.isHidden = true
            greenTickButtonSecond.isHidden = false
        }   
    }
    
    @IBAction func purchaseButtonAction(_ sender: Any) {
       
    }
}
