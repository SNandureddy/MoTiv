//
//  CustomAlert.swift
//  QUTELINKS
//
//  Created by ios on 24/04/18.
//  Copyright © 2018 ios. All rights reserved.
//

import UIKit

typealias ButtonAction = (()->())

class CustomAlert: UIView {
    
    //MARK: IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var middleLineView: UIView!
    
    //MARK: Variables
    
    //MARK: Setup
    convenience init(title:String?, message: String?, cancelButtonTitle: String? = nil, doneButtonTitle: String = "OKAY") {
        
        self.init(frame: UIScreen.main.bounds)
        self.initialize(title:title, message: message, cancelButtonTitle: cancelButtonTitle, doneButtonTitle: doneButtonTitle)
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
    
    private func initialize(title:String?, message: String?, cancelButtonTitle: String? = nil, doneButtonTitle: String = "OKAY") {
        popUpView.set(radius: 14.0)
        popUpView.setShadow()
        self.titleLabel.text = title?.uppercased()
        self.messageLabel.text = message?.uppercased()
        self.doneButton.setTitle(doneButtonTitle.uppercased(), for: .normal)
        self.titleLabel.isHidden = title == nil
        self.messageLabel.isHidden = message == nil
        self.cancelButton.isHidden = cancelButtonTitle == nil
        self.middleLineView.isHidden = cancelButtonTitle == nil
        self.cancelButton.setTitle(cancelButtonTitle?.uppercased(), for: .normal)
    }
    
    //MARK: Show Alert
    func show() {
        self.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func remove() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.alpha = 0
        }, completion: {(success) in
            self.removeFromSuperview()
        })
    }

    //MARK: IBActions
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.remove()
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.remove()
    }
    
}

//For Handle Action
class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}


//Add Target With Closure
extension UIControl {
    func addTarget (action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: UIControlEvents.touchUpInside)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(UIControlEvents.touchUpInside.rawValue), sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
