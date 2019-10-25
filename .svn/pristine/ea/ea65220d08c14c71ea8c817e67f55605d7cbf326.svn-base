//
//  BlockedUSerTableViewCell.swift
//  MoTiv
//
//  Created by Deftsoft on 06/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class BlockedUSerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var unblockButton: UIButton!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.customUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func customUI(){
        self.unblockButton.setBackgroundImage(self.unblockButton.graidentImage, for: .normal)
        self.unblockButton.set(radius: 10.0)
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
}
