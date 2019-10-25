//
//  TextViewCell.swift
//  MoTiv
//
//  Created by IOS on 26/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
