//
//  DashBoardVC.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit
import SwiftChartView

class DashBoardVC: BaseVC {
    
    //MARK: IBOutlets
    @IBOutlet weak var totalSalesAmountLabel: UILabel!
    @IBOutlet weak var totalSalesBaseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var selectedTag = 1         // 1=>hourly,2=>daily,3=>weekly,4=>monthly
    var selectedIndex = Int()
    
    //MARLK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDashboardData(chartType: 1)    // 1=>sales_chart,2=>check_in_summary
//        getDashboardData(chartType: 2)
        customiseUI()
    }
    
    //MARK: Private Methods
    private func customiseUI(){
        setTitle(title: kDashboard)
        self.totalSalesBaseView.set(radius: 14.0)
    }
}



//MARK: UITableview Datasource
extension DashBoardVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kSalesSummaryCell) as! SalesSummaryCell
            cell.hourlyBuytton.addTarget(self, action: #selector(self.timeSelectionAction(sender:)), for: .touchUpInside)
            cell.dailyButton.addTarget(self, action: #selector(self.timeSelectionAction(sender:)), for: .touchUpInside)
            cell.weeklyBUtton.addTarget(self, action: #selector(self.timeSelectionAction(sender:)), for: .touchUpInside)
            cell.monthlyButton.addTarget(self, action: #selector(self.timeSelectionAction(sender:)), for: .touchUpInside)
            let seriesData: [Double]?
            var chartPoints: [ChartPoint]?
            if selectedTag == 1 {
                seriesData = EventVM.shared.dashboardRecordsArray?.map({Double($0.bought ?? 0)}) ?? [Double]()
                chartPoints = {
                    var chartPoints: [ChartPoint] = []
                    for i in 0 ..< 24 {
                        if i >= seriesData?.count ?? 0 {
                            if (i+1) % 3 != 0 {
                                let chartPoint = ChartPoint(label: "", value: 0)
                                chartPoints.append(chartPoint)
                            } else {
                                let chartPoint = ChartPoint(label: "\(i+1)", value: 0)
                                chartPoints.append(chartPoint)
                            }
                        } else {
                            if (i+1) % 3 != 0 {
                                let chartPoint = ChartPoint(label: "", value: seriesData?[i] ?? Double())
                                chartPoints.append(chartPoint)
                            } else {
                                let chartPoint = ChartPoint(label: "\(i+1)", value: seriesData?[i] ?? Double())
                                chartPoints.append(chartPoint)
                            }
                        }
                    }
                    return chartPoints
                }()
            } else if selectedTag == 2 {
                seriesData = EventVM.shared.dashboardRecordsArray?.map({Double($0.bought ?? 0)}) ?? [Double]()
                chartPoints = {
                    var chartPoints: [ChartPoint] = []
                    for i in 0 ..< 31 {
                        if i >= seriesData?.count ?? 0 {
                            if (i+1) % 3 != 0 {
                                let chartPoint = ChartPoint(label: "", value: 0)
                                chartPoints.append(chartPoint)
                            } else {
                                let chartPoint = ChartPoint(label: "\(i+1)", value: 0)
                                chartPoints.append(chartPoint)
                            }
                        } else {
                            if (i+1) % 3 != 0 {
                                let chartPoint = ChartPoint(label: "", value: seriesData?[i] ?? Double())
                                chartPoints.append(chartPoint)
                            } else {
                                let chartPoint = ChartPoint(label: "\(i+1)", value: seriesData?[i] ?? Double())
                                chartPoints.append(chartPoint)
                            }
                        }
                    }
                    return chartPoints
                }()
            } else if selectedTag == 3 {
                seriesData = EventVM.shared.dashboardRecordsArray?.map({Double($0.bought ?? 0)}) ?? [Double]()
                chartPoints = {
                    var chartPoints: [ChartPoint] = []
                    for i in 0 ..< 10 {
                        if i >= seriesData?.count ?? 0 {
                            let chartPoint = ChartPoint(label: "\(i+1)", value: 0)
                            chartPoints.append(chartPoint)
                        } else {
                            let chartPoint = ChartPoint(label: "\(i+1)", value: seriesData?[i] ?? Double())
                            chartPoints.append(chartPoint)
                        }
                    }
                    return chartPoints
                }()
            } else {
                seriesData = EventVM.shared.dashboardRecordsArray?.map({Double($0.bought ?? 0)}) ?? [Double]()
                chartPoints = {
                    var chartPoints: [ChartPoint] = []
                    for i in 0 ..< 12 {
                        if i >= seriesData?.count ?? 0 {
                            let chartPoint = ChartPoint(label: "\(i+1)", value: 0)
                            chartPoints.append(chartPoint)
                        } else {
                            let chartPoint = ChartPoint(label: "\(i+1)", value: seriesData?[i] ?? Double())
                            chartPoints.append(chartPoint)
                        }
                    }
                    return chartPoints
                }()
            }
            cell.salesGraphView.chartPoints = chartPoints ?? [ChartPoint]()
            cell.handleGraph()
            cell.salesTableView.reloadData()
            (cell.viewWithTag(1) as! UIButton).backgroundColor = UIColor.motivColor.baseColor.color()
            (cell.viewWithTag(2) as! UIButton).backgroundColor = UIColor.motivColor.baseColor.color()
            (cell.viewWithTag(3) as! UIButton).backgroundColor = UIColor.motivColor.baseColor.color()
            (cell.viewWithTag(4) as! UIButton).backgroundColor = UIColor.motivColor.baseColor.color()
            (cell.viewWithTag(selectedTag) as! UIButton).backgroundColor = UIColor.motivColor.darkBaseColor.color()
            let height = cell.salesTableView.contentSize.height
            cell.salesTableViewHeight.constant = height
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCheckInSummaryCell) as! CheckInSummaryCell
            cell.checkinDataTableView.reloadData()
            let height = cell.checkinDataTableView.contentSize.height
            cell.checkInTableViewHeightConstraint.constant = height
            return cell
        }
    }

    @objc func timeSelectionAction(sender: UIButton) {
        if selectedTag == sender.tag {
            return
        }
        selectedTag = sender.tag
        getDashboardData(chartType: 1)
//        getDashboardData(chartType: 2)
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        })
    }
}

//MARK: - API Calls
extension DashBoardVC {
    func getDashboardData(chartType: Int){
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = EventVM.shared.checkInEventDetailArray?[selectedIndex].eventID
        dict[APIKeys.kType] = self.selectedTag
        dict[APIKeys.kChartType] = chartType
        EventVM.shared.getDashboardData(dict: dict){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
            } else{
                self.totalSalesAmountLabel.text = "\(EventVM.shared.grossSales ?? 0)"
                self.tableView.reloadData()
            }
        }
    }
}
