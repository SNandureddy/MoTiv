//
//  PostSectionCell.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class PostSectionCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet var commentsButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}