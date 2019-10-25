//
//  AddGuestCell.swift
//  MoTiv
//
//  Created by ios2 on 04/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class AddGuestCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var emailAddressTextField: TextField!
    @IBOutlet weak var organisationTextField: TextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func customUI(){
        self.nameTextField.set(radius: 14.0)
        self.emailAddressTextField.set(radius: 14.0)
        self.organisationTextField.set(radius: 14.0)
    }
}
