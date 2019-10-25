//
//  TicketDetailsCell.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class TicketDetailsCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var ticketTitleLabel: UILabel!
    @IBOutlet weak var ticketDetailLabel: UILabel!
    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.customUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func customUI(){
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
}