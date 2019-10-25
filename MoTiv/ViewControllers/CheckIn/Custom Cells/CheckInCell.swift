//
//  CheckInCell.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class CheckInCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ticketNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.customiseUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func customiseUI(){
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
    
}