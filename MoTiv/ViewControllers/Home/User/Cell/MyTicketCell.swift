//
//  MyTicketCell.swift
//  MoTiv
//
//  Created by IOS on 10/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class MyTicketCell: UITableViewCell {
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ticketsLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
