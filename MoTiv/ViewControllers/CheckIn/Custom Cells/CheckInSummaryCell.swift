//
//  CheckInSummaryCell.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class CheckInSummaryCell: UITableViewCell {

    @IBOutlet var checkinDataTableView: UITableView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet var checkInTableViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func customUI(){
        checkinDataTableView.delegate = self
        checkinDataTableView.dataSource = self
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
}

//MARK: UITableView Datasource and Delegates

extension CheckInSummaryCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCheckinDataCell) as! SalesDataTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTotalCheckinCell) as! SalesDataTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
