//
//  Popover.swift
//  MoTiv
//
//  Created by IOS on 07/12/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import UIKit

class PopOver: UIView {

    //MARK: IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var view: UIView!
    
    //MARK: Setup
    convenience init(width: CGFloat = 120, height: CGFloat = 80, title: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.initialize(title:title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: Private Methods
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView { //Load View from Nib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func initialize(title:String) {
        self.titleLabel.text = title
        var testRect: CGRect = self.frame
        testRect.size.height = titleLabel.frame.height-40
        self.frame = testRect

    }
}
