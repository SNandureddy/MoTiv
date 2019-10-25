//
//  SalesSummaryCell.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SwiftChartView

class SalesSummaryCell: UITableViewCell {

    @IBOutlet weak var hourlyBuytton: UIButton!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var weeklyBUtton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet var salesTableView: UITableView!
    @IBOutlet var salesTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet var salesGraphView: BarChartView!
    
    var refreshControl = UIRefreshControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        salesTableView.delegate = self
        salesTableView.dataSource = self
        customUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customUI(){
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
    
    func handleGraph() {
        salesGraphView.axisColor = .white
        salesGraphView.lineColor = UIColor.motivColor.baseColor.color()
        salesGraphView.lineWidth = 7.0
        salesGraphView.xLabelFontSize = 12.0
        salesGraphView.yLabelFontSize = 0.0
        salesGraphView.xMargin = 8.0
        salesGraphView.animationDuration = 4.0
    }
}

//MARK: UITableView Datasource and Delegates

extension SalesSummaryCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventVM.shared.dashboardTicketsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTicketDataCell) as! SalesDataTableViewCell
        cell.recordLabel.text = "\(EventVM.shared.dashboardTicketsArray?[indexPath.row].boughtTickets ?? 0)/\(EventVM.shared.dashboardTicketsArray?[indexPath.row].ticketQuantity ?? 0)"
        cell.ticketNameLabel.text = EventVM.shared.dashboardTicketsArray?[indexPath.row].ticketTitle
        cell.handleProgessBar(ticketBought: Double(EventVM.shared.dashboardTicketsArray?[indexPath.row].boughtTickets ?? 0), totalTicket: Double(EventVM.shared.dashboardTicketsArray?[indexPath.row].ticketQuantity ?? 0))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTicketSoldCell) as! SalesDataTableViewCell
        cell.recordLabel.text = "\(EventVM.shared.totalBoughtTickets ?? 0)/\(EventVM.shared.totalTickets ?? 0)"
        cell.handleProgessBar(ticketBought: Double(EventVM.shared.totalBoughtTickets ?? 0), totalTicket: Double(EventVM.shared.totalTickets ?? 0))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
