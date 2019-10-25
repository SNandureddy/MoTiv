//
//  UserCell.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
