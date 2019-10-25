//
//  InterestCell.swift
//  MoTiv
//
//  Created by ios2 on 15/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class InterestCell: UITableViewCell {
  
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var interestNameLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
       customUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func customUI(){
        self.baseView.set(radius: 14.0)
        self.baseView.setShadow()
    }
}
