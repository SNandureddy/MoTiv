//
//  SelectTicketVC.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SelectTicketVC: BaseVC {
    
    //MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buyTicketsButton: UIButton!
    
    //MARK: - Variables
    var selectedIndex = Int()
    var ticketPrice = [Double]()
    var type: PreviousScreen = .main
    var categoryEventDetailArray = [SearchEventDetail]()
    var ticketCount : Int?
    var subtotal : Double?
    
    //MARLK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getTicketList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customUI()
    }
    
    //MARK:- Private func
    func customUI(){
        setTitle(title: kSelectTickets)
        self.buyTicketsButton.setBackgroundImage(self.buyTicketsButton.graidentImage, for: .normal)
        self.buyTicketsButton.set(radius: 14.0)
        ticketCount = EventVM.shared.ticketListArray?.map({$0.ticketCount ?? 0}).reduce(0, +) ?? 0
        subtotal = EventVM.shared.ticketListArray?.map({$0.ticketPrice ?? 0.0}).reduce(0, +) ?? 0.0
        self.buyTicketsButton.setTitle("BUY \(self.ticketCount ?? 0) TICKETS: \((self.subtotal ?? 0).roundToTwoDecimal.amountValue)", for: .normal)
        tableView.reloadData()
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = type == .search ? categoryEventDetailArray[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        return dict
    }
    
    
    //MARK:- IBAction
    @IBAction func buyTicketButtonAction(_ sender: Any) {
        if self.ticketCount == 0 {
            showAlert(message: "Please add at least 1 ticket to proceed.")
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: kTicketDetailsVC) as! TicketDetailsVC
        vc.selectedIndex = self.selectedIndex
        if type == .search {
            vc.type = .search
            vc.categoryEventDetailArray = self.categoryEventDetailArray
        }
        self.navigationController?.show(vc, sender: self)
    }
}

//MARK: UITableview Datasource
extension SelectTicketVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.ticketListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kSelectTicketCell) as! SelectTicketCell
        cell.ticketDescriptionLabel.text = EventVM.shared.ticketListArray?[indexPath.row].ticketDescription
        cell.ticketTitleLabel.text = EventVM.shared.ticketListArray?[indexPath.row].ticketTitle
        cell.ticketPriceLabel.text = Double(EventVM.shared.ticketListArray?[indexPath.row].ticketAmount ?? 0).roundToTwoDecimal.amountValue
        cell.ticketCountBaseView.isHidden = EventVM.shared.ticketListArray?[indexPath.row].ticketCount == 0 ? true : false
        cell.addButton.isHidden = EventVM.shared.ticketListArray?[indexPath.row].ticketCount == 0 ? false : true
        cell.addButton.addTarget(self, action: #selector(self.addButtonAction(sender:)), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(self.increaseAction(sender:)), for: .touchUpInside)
        cell.decreaseButton.addTarget(self, action: #selector(self.decreaseAction(sender:)), for: .touchUpInside)
        cell.addButton.tag = indexPath.row
        cell.increaseButton.tag = indexPath.row
        cell.decreaseButton.tag = indexPath.row
        
        return cell
    }
    
    @objc override func addButtonAction(sender: UIButton) {
        if (EventVM.shared.ticketListArray?[sender.tag].remainingTickets ?? 0) == 0 {
            showAlert(message: "All tickets are sold.")
            return
        }
        if let cell = sender.superview?.superview?.superview?.superview as? SelectTicketCell {
            EventVM.shared.ticketListArray?[sender.tag].ticketCount = 1
            EventVM.shared.ticketListArray?[sender.tag].ticketPrice = Double((EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) * (EventVM.shared.ticketListArray?[sender.tag].ticketAmount ?? 0))
            cell.ticketCountButton.setTitle("\(EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0)", for: .normal)
            cell.addButton.isHidden = true
            cell.ticketCountBaseView.isHidden = false
            self.subtotal = EventVM.shared.ticketListArray?.map({$0.ticketPrice ?? 0.0}).reduce(0, +) ?? 0.0
            self.ticketCount = EventVM.shared.ticketListArray?.map({$0.ticketCount ?? 0}).reduce(0, +) ?? 0
            self.buyTicketsButton.setTitle("BUY \(self.ticketCount ?? 0) TICKETS: \((self.subtotal ?? 0).roundToTwoDecimal.amountValue)", for: .normal)
        }
    }
    
    @objc func increaseAction(sender: UIButton) {
        if let cell = sender.superview?.superview?.superview?.superview?.superview as? SelectTicketCell {
            if (EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) == (EventVM.shared.ticketListArray?[sender.tag].remainingTickets ?? 0)  {
                showAlert(message: "Maximum Limit Reached")
                return
            }
            EventVM.shared.ticketListArray?[sender.tag].ticketCount = (EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) + 1
            EventVM.shared.ticketListArray?[sender.tag].ticketPrice = Double((EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) * (EventVM.shared.ticketListArray?[sender.tag].ticketAmount ?? 0))
            cell.ticketCountButton.setTitle("\(EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0)", for: .normal)
            self.subtotal = EventVM.shared.ticketListArray?.map({$0.ticketPrice ?? 0.0}).reduce(0, +) ?? 0.0
            self.ticketCount = EventVM.shared.ticketListArray?.map({$0.ticketCount ?? 0}).reduce(0, +) ?? 0
            self.buyTicketsButton.setTitle("BUY \(self.ticketCount ?? 0) TICKETS: \((self.subtotal ?? 0).roundToTwoDecimal.amountValue)", for: .normal)
        }
    }
    
    @objc func decreaseAction(sender: UIButton) {
        if let cell = sender.superview?.superview?.superview?.superview?.superview as? SelectTicketCell {
            if (EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) == 1 {
                EventVM.shared.ticketListArray?[sender.tag].ticketCount = 0
                EventVM.shared.ticketListArray?[sender.tag].ticketPrice = Double((EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) * (EventVM.shared.ticketListArray?[sender.tag].ticketAmount ?? 0))
                cell.addButton.isHidden = false
                cell.ticketCountBaseView.isHidden = true
                self.subtotal = EventVM.shared.ticketListArray?.map({$0.ticketPrice ?? 0.0}).reduce(0, +) ?? 0.0
                self.ticketCount = EventVM.shared.ticketListArray?.map({$0.ticketCount ?? 0}).reduce(0, +) ?? 0
                self.buyTicketsButton.setTitle("BUY \(self.ticketCount ?? 0) TICKETS: \((self.subtotal ?? 0).roundToTwoDecimal.amountValue)", for: .normal)
                return
            } else {
                EventVM.shared.ticketListArray?[sender.tag].ticketCount = (EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) - 1
                EventVM.shared.ticketListArray?[sender.tag].ticketPrice = Double((EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0) * (EventVM.shared.ticketListArray?[sender.tag].ticketAmount ?? 0))
                cell.ticketCountButton.setTitle("\(EventVM.shared.ticketListArray?[sender.tag].ticketCount ?? 0)", for: .normal)
                self.subtotal = EventVM.shared.ticketListArray?.map({$0.ticketPrice ?? 0.0}).reduce(0, +) ?? 0.0
                self.ticketCount = EventVM.shared.ticketListArray?.map({$0.ticketCount ?? 0}).reduce(0, +) ?? 0
                self.buyTicketsButton.setTitle("BUY \(self.ticketCount ?? 0) TICKETS: \((self.subtotal ?? 0).roundToTwoDecimal.amountValue)", for: .normal)
            }
        }
    }
}

//MARK: UItableview Delegates
extension SelectTicketVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: API Methods

extension SelectTicketVC {
    func getTicketList(){
        EventVM.shared.ticketListArray?.removeAll()
        EventVM.shared.getTicketList(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.tableView.reloadData()
            }
        }
    }
}

