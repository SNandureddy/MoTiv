
//
//  SelectPaymentMethodVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SelectPaymentMethodVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var applePayButton: UIButton!
    @IBOutlet weak var cardButton: UIButton!
    
    //MARK: - Variables
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: kSelectPaymentMethod)
        self.applePayButton.setBackgroundImage(self.applePayButton.graidentImage, for: .normal)
        self.applePayButton.set(radius: 14.0)
        self.cardButton.setBackgroundImage(self.cardButton.graidentImage, for: .normal)
        self.cardButton.set(radius: 14.0)
    }
    
    //MARK:- IBAction
    @IBAction func applePayButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func cardButtonAction(_ sender: Any) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kSelectCardVC) as! SelectCardVC
        self.navigationController?.show(detailvc, sender: self)
    }
    
    
    
    
}
