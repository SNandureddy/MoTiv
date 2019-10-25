//
//  EventCell.swift
//  MoTiv
//
//  Created by IOS on 27/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet var eventImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var ticketSoldLabel: UILabel!
    @IBOutlet var guestListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}