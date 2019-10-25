//
//  GuestCell.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class GuestCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ticketNameLabel: UILabel!
    @IBOutlet weak var uniqueIdLabel: UILabel!
    @IBOutlet weak var crossbutton: UIButton!
    @IBOutlet weak var baseView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customUI() {
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
    
}
