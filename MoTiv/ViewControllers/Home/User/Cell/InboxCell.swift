//
//  InboxCell.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class InboxCell: UITableViewCell {
    //MARK:IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lastMsgLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
