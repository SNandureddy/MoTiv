//
//  TicketDetailsVC.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//


import UIKit

class TicketDetailsVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    //MARK: - Variables
    var ticketDetailArray = [TicketList]()
    var type: PreviousScreen = .main
    var selectedIndex = Int()
    var categoryEventDetailArray = [SearchEventDetail]()
    var subtotal : Double?
    var taxAmount : Double?
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.taxAmount = 1.25
        self.ticketDetailArray = (EventVM.shared.ticketListArray?.filter{($0.ticketCount ?? 0) > 0}) ?? [TicketList]()
        subtotal = ticketDetailArray.map({$0.ticketPrice ?? 0.0}).reduce(0, +)
        self.customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: kBuyNow)
        self.tableView.tableFooterView = UIView()
        self.proceedButton.setBackgroundImage(self.proceedButton.graidentImage, for: .normal)
        self.proceedButton.set(radius: 14.0)
        self.subTotalLabel.text = (self.subtotal ?? 0).roundToTwoDecimal.amountValue
        self.taxLabel.text = (self.taxAmount ?? 0.0).roundToTwoDecimal.amountValue
        self.totalLabel.text = ((self.subtotal ?? 0.0) + (self.taxAmount ?? 0.0)).roundToTwoDecimal.amountValue
        tableView.reloadData()
    }
    
    func setDataToBookTicket() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kSmallTickets] = getObjectStringFrom(jsonArray: handleTicketData())
        dict[APIKeys.kCardNumber] = 212122121
        dict[APIKeys.kToken] = "dsdgsdgsdg"
        dict[APIKeys.kCardType] = 1       // 1 - Debit, 2 - Credit
        dict[APIKeys.kIsSave] = 1         // 1 - Yes, 2 - No
        dict[APIKeys.kPaymentType] = 1    // 1- New Card, 2 - Saved Card
        dict[APIKeys.kTotalAmount] = (self.subtotal ?? 0.0) + (self.taxAmount ?? 0.0)
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        return dict
    }
    
    func handleTicketData() -> JSONArray {
        var ticketData = JSONArray()
        for i in 0...ticketDetailArray.count - 1 {
            let dict = [APIKeys.kTicketId : ticketDetailArray[i].ticketId ?? 0 , APIKeys.kQuantity : ticketDetailArray[i].ticketCount ?? 0, APIKeys.kAmount : ((ticketDetailArray[i].ticketAmount ?? 0) * (ticketDetailArray[i].ticketCount ?? 0))] as JSONDictionary
            ticketData.append(dict)
        }
        return ticketData
    }
    
    //MARK:- IBAction
    @IBAction func proceedButtonAction(_ sender: Any) {
//        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kSelectPaymentMethodVC) as! SelectPaymentMethodVC
//        self.navigationController?.show(detailvc, sender: self)
        self.callApiToBookTicket()
    }
}

//MARK: UITableview Datasource
extension TicketDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketDetailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTicketDetailsCell) as! TicketDetailsCell
        cell.ticketTitleLabel.text = ticketDetailArray[indexPath.row].ticketTitle
        cell.ticketDetailLabel.text = ticketDetailArray[indexPath.row].ticketDescription
        cell.ticketCountLabel.text = "\(ticketDetailArray[indexPath.row].ticketCount ?? 0) X \(Double(ticketDetailArray[indexPath.row].ticketAmount ?? 0).roundToTwoDecimal.amountValue)"
        cell.crossButton.addTarget(self, action: #selector(self.crossButtonAction(sender:)), for: .touchUpInside)
        cell.crossButton.tag = indexPath.row
        return cell
    }
    @objc func crossButtonAction(sender: UIButton) {
        showAlert(title: nil, message: kDeleteTicketMessage, cancelTitle: kCancel, cancelAction: nil, okayTitle: kDelete) {
            self.resetDataToMainArray(index: sender.tag)
            self.ticketDetailArray.remove(at: sender.tag)
            self.subtotal = self.ticketDetailArray.map({$0.ticketPrice ?? 0.0}).reduce(0, +)
            self.subTotalLabel.text = (self.subtotal ?? 0).roundToTwoDecimal.amountValue
            self.totalLabel.text = ((self.subtotal ?? 0.0) + (self.taxAmount ?? 0.0)).roundToTwoDecimal.amountValue
            self.tableView.reloadData()
            if self.ticketDetailArray.count == 0 {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    //resetig quantitiy to main array
    func resetDataToMainArray(index : Int){
        let id = self.ticketDetailArray[index].ticketId
        if let indexInArray = EventVM.shared.ticketListArray?.firstIndex(where: {$0.ticketId == id}) {
            EventVM.shared.ticketListArray?[indexInArray].ticketCount = 0
            EventVM.shared.ticketListArray?[indexInArray].ticketPrice = 0.0
        }
    }
}

//MARK: UItableview Delegates
extension TicketDetailsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: kEventDetails) as! EventDetailVC
        //        self.navigationController?.show(detailvc, sender: self)
    }
}

//MARK: API Methods
extension TicketDetailsVC {
    func callApiToBookTicket() {
        EventVM.shared.bookTicket(dict: setDataToBookTicket()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.showAlert(title: nil, message: "Tickets Bought Successfully", cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
        }
    }
}
