//
//  SelectTicketCell.swift
//  MoTiv
//
//  Created by ios2 on 29/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class SelectTicketCell: UITableViewCell {

    //MARK:- IBOutlets
    
    @IBOutlet weak var ticketCountButton: UIButton!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var ticketDescriptionLabel: UILabel!
    @IBOutlet weak var ticketTitleLabel: UILabel!
    @IBOutlet weak var ticketCountBaseView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var ticketPriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK:- Private func
    func customUI(){
        self.ticketCountButton.setBackgroundImage(self.ticketCountButton.graidentImage, for: .normal)
        self.ticketCountButton.set(radius: 7.0)
        self.addButton.setBackgroundImage(self.addButton.graidentImage, for: .normal)
        self.addButton.set(radius: 7.0)
        baseView.set(radius: 14.0)
        baseView.setShadow()
    }
}
