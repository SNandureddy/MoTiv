//
//  TicketCell.swift
//  MoTiv
//
//  Created by IOS on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ticketCountLabel: UILabel!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
