//
//  SelectCardVC.swift
//  MoTiv
//
//  Created by ios2 on 15/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SelectCardVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardNumberTextField: TextField!
    @IBOutlet weak var cvvTextField: TextField!
    @IBOutlet weak var expiryDateTextField: TextField!
    @IBOutlet weak var creaditCardButton: UIButton!
    @IBOutlet weak var debitCardButton: UIButton!
    @IBOutlet weak var makePyamentButton: UIButton!
    
    //MARK: - Variables
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: kSelectCard)
        setExpirationDate()
        self.makePyamentButton.setBackgroundImage(self.makePyamentButton.graidentImage, for: .normal)
        self.makePyamentButton.set(radius: 14.0)
        self.cardNumberTextField.set(radius: 14.0)
        self.cvvTextField.set(radius: 14.0)
        self.expiryDateTextField.set(radius: 14.0)
    }
    
    private func setExpirationDate() {
        let datePicker = MonthYearPickerView()
        expiryDateTextField.inputView = datePicker
        datePicker.onDateSelected = {(month: Int, year: Int) in
            let string = String(format: "%02d/ %d", month, year)
            self.expiryDateTextField.text = string
            self.expiryDateTextField.rightImage = self.expiryDateTextField.text!.count > 0 ?  #imageLiteral(resourceName: "cardSelected") : #imageLiteral(resourceName: "dateUnSelected")
            self.expiryDateTextField.text!.count > 0 ? self.expiryDateTextField.setShadow(): self.expiryDateTextField.removeShadow()
        }
    }

    
    //MARK:- IBAction
    @IBAction func saveForFutureButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    @IBAction func creditaCardButtonAction(_ sender: Any) {
        creaditCardButton.backgroundColor = UIColor.motivColor.darkBaseColor.color()
        debitCardButton.backgroundColor = UIColor.motivColor.baseColor.color()
    }
    @IBAction func debitCardButtonAction(_ sender: Any) {
        creaditCardButton.backgroundColor = UIColor.motivColor.baseColor.color()
        debitCardButton.backgroundColor = UIColor.motivColor.darkBaseColor.color()
    }
    @IBAction func makePaymentButtonAction(_ sender: Any) {
        self.showAlert(title: kSuccess, message: kPaymentSucess, okayTitle: kOkay) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK: TextField Actions
    @IBAction func textFieldDidChange(_ sender: TextField) {
        switch sender {
        case cardNumberTextField:
            cardNumberTextField.rightImage = cardNumberTextField.text!.count > 0 ? #imageLiteral(resourceName: "cardSelected") : #imageLiteral(resourceName: "cardUnSelected")
            cardNumberTextField.text!.count > 0 ? cardNumberTextField.setShadow(): cardNumberTextField.removeShadow()
            break
        case cvvTextField:
            cvvTextField.rightImage = cvvTextField.text!.count > 0 ?  #imageLiteral(resourceName: "cardSelected") : #imageLiteral(resourceName: "cvvUnSelected")
            cvvTextField.text!.count > 0 ? cvvTextField.setShadow(): cvvTextField.removeShadow()
            break
        case expiryDateTextField:
            expiryDateTextField.rightImage = expiryDateTextField.text!.count > 0 ?  #imageLiteral(resourceName: "cardSelected") : #imageLiteral(resourceName: "dateUnSelected")
            expiryDateTextField.text!.count > 0 ? expiryDateTextField.setShadow(): expiryDateTextField.removeShadow()
            break
        default:
            break
        }
    }
    
}

//MARK: UITableview Datasource
extension SelectCardVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSelectCardCell) as! SelectCardCell
        return cell
    }
    
}

//MARK: UItableview Delegates
extension SelectCardVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSelectCardCellHeader) as! SelectCardCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        //        self.navigationController?.show(detailvc, sender: self)
    }
}
