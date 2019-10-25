//
//  TableViewController.swift
//  MoTiv
//
//  Created by IOS on 18/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class TableView: UITableView {
    
    @IBInspectable var imageForEmptyScreen:UIImage = #imageLiteral(resourceName: "notificationSelected") {
        didSet {
            emptyview.imageView.image = imageForEmptyScreen
        }
    }
    @IBInspectable var titleForEmptyScreen:String = "" {
        didSet {
            emptyview.titleLabel.text = titleForEmptyScreen
        }
    }
    @IBInspectable var descriptionForEmptyScreen:String = "" {
        didSet {
            emptyview.descriptionLabel.text = descriptionForEmptyScreen
        }
    }
    
    
    
    lazy var emptyview:EmptyScreenView = EmptyScreenView(image: self.imageForEmptyScreen, title: self.titleForEmptyScreen, description: self.descriptionForEmptyScreen)


    //MARK: Empty Screen Implementation
    func showEmptyScreen(belowSubview subview: UIView? = nil, superView:UIView? = nil) {
        let baseView: UIView = superView ?? self
        emptyview.imageView.tintColor = UIColor.white
        emptyview.frame = CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height)
        if let subview = subview {
            baseView.insertSubview(emptyview, belowSubview: subview)
        }
        else {
            baseView.addSubview(emptyview)
        }
    }
    
    func hideEmptyScreen() {
        emptyview.removeFromSuperview()
    }

}
