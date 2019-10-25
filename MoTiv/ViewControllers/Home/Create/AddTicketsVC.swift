//
//  AddTicketsVC.swift
//  MoTiv
//
//  Created by IOS on 05/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

protocol TicketDelegate {
    func didCreateTicket(ticket: JSONDictionary)
}

class AddTicketsVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var addTicketButton: UIButton!
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: Variables
    var delegate: TabViewDelegate!
    var ticketArray = JSONArray()
    var isUpdate = false
    var selectedIndex = Int()

    //MARK: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUpdate {
            getTicketList()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI() {
        addTicketButton.set(radius: 14.0)
        nextButton.set(radius: 14.0)
        addTicketButton.setBackgroundImage(addTicketButton.graidentImage, for: .normal)
        nextButton.setBackgroundImage(nextButton.graidentImage, for: .normal)
    }
    
    func setData() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = EventVM.shared.eventDetailArray?[selectedIndex].eventID
        return dict
    }
    
    func getTicketsForUpdate() -> JSONArray {
        var ticketData = JSONArray()
        for i in 0...(EventVM.shared.ticketListArray?.count ?? 0) - 1 {
            let dict = [APIKeys.kTicketTitle : EventVM.shared.ticketListArray?[i].ticketTitle ?? "", APIKeys.kTicketDescription : EventVM.shared.ticketListArray?[i].ticketDescription ?? "", APIKeys.kTicketAmount : "\(Double(EventVM.shared.ticketListArray?[i].ticketAmount ?? 0).roundToTwoDecimal)", APIKeys.kTicketQuantity : EventVM.shared.ticketListArray?[i].ticketQuantity ?? "0"] as JSONDictionary
            ticketData.append(dict)
        }
        return ticketData
    }
    
    //MARK: IBActions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if let message = validateData() {
            self.showAlert(message: message)
            return
        }
        let viewMotivVC = self.storyboard?.instantiateViewController(withIdentifier: kViewMotivVC) as! ViewMotivVC
        viewMotivVC.selectedIndex = self.selectedIndex
        viewMotivVC.isUpdate = self.isUpdate
        self.navigationController?.show(viewMotivVC, sender: self)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CreateTicketVC {
            destination.delegate = self
        }
    }
}

//MARK: UItablewVeiw Datasource
extension AddTicketsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ticketArray.count > 0 ? self.tableView.hideEmptyScreen(): self.tableView.showEmptyScreen()
        return ticketArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTicketCell) as! TicketCell
        cell.titleLabel.text = ticketArray[indexPath.row][APIKeys.kTicketTitle] as? String
        cell.descriptionLabel.text = ticketArray[indexPath.row][APIKeys.kTicketDescription] as? String
        cell.amountLabel.text = "\((ticketArray[indexPath.row][APIKeys.kTicketAmount] as? NSString)?.doubleValue.roundToTwoDecimal.amountValue ?? "")"
        cell.ticketCountLabel.text = "TICKETS AVAILABLE: \(ticketArray[indexPath.row][APIKeys.kTicketQuantity] ?? "0")"
        cell.backView.set(radius: 14.0)
        cell.backView.setShadow()
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(self.deleteButtonAction(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteButtonAction(sender: UIButton) {
        self.showAlert(title: "delete ticket", message: "are you sure you want to delete ticket ?", cancelTitle: kCancel, cancelAction: {
            
        }, okayTitle: kYes) {
            self.ticketArray.remove(at: sender.tag)
            self.tableView.reloadData()
        }
    }
}

extension AddTicketsVC: TicketDelegate {
    
    func didCreateTicket(ticket: JSONDictionary) {
        ticketArray.append(ticket)
        tableView.reloadData()
    }
}

//MARK: Validations
extension AddTicketsVC {
    
    func validateData() -> String? {
        if ticketArray.count == 0 {
            return kTicketsValidation
        }
//        var string = self.json(from: ticketArray)
//        string = string?.replacingOccurrences(of: "\\", with: "")
        O_CreateMainVC.createDict[APIKeys.kAddTicket] = ticketArray
        return nil
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }

}

//MARK: API Method
extension AddTicketsVC {
    func getTicketList(){
        EventVM.shared.getTicketList(dict: setData()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.ticketArray = self.getTicketsForUpdate()
                self.tableView.reloadData()
            }
        }
    }
}
