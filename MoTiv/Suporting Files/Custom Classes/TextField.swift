//
//  TextField.swift
//  MoTiv
//
//  Created by Apple on 20/09/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 37)
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    @IBInspectable var imageWidth: CGFloat = 30 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var imageHeight: CGFloat = 30 {
        didSet {
            updateView()
        }
    }

    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    // Provides Padding for Images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }


    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = UIColor.clear
            leftView = imageView
        }
        else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            imageView.tintColor = UIColor.clear
            rightView = imageView
        }
        else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: placeholderColor])
        keyboardAppearance = .dark
        tintColor = UIColor.white
        self.autocorrectionType = .no
    }
}
