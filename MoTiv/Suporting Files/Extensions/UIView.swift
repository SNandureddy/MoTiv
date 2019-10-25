//
//  UIView.swift
//  HealthSplash
//
//  Created by Apple on 16/11/17.
//  Copyright © 2017 Deftsfot. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var half: CGFloat {
        return self.frame.height/2
    }
    
    @IBInspectable var cornerRadius : CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set
        {
            layer.borderWidth = newValue
        }
        
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor.init(cgColor: color)
            }
            return nil
        }
        set(newValue) {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func set(radius: CGFloat, borderColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0.0) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    func setShadow() {
        self.layer.borderColor = UIColor.motivColor.baseColor.color().cgColor
        self.layer.borderWidth = 1.0
//        self.layer.shadowColor = UIColor.motivColor.baseColor.color().cgColor
//        self.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.layer.shadowOpacity = 0.7
//        self.layer.shadowRadius = 1.0
//
//        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale

//        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
//        self.layer.shadowColor = UIColor.motivColor.baseColor.color().cgColor
//        self.layer.shadowOffset = CGSize.zero
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.4
        
    }
    
    func addBackground() {
        self.backgroundColor = UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 0.5)
    }
    
    func removeBackground() {
        self.backgroundColor = UIColor.clear
    }
    
    
    func removeShadow() {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.shadowOpacity = 0.0
    }
    
    func generateShadowUsingBezierPath(radius: CGFloat)  {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        let shadow = UIView(frame: self.frame)
        shadow.backgroundColor = .white
        shadow.isUserInteractionEnabled = false
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowRadius = 2.0
        shadow.layer.masksToBounds = false
        shadow.layer.cornerRadius = self.layer.cornerRadius
        shadow.layer.shadowOpacity = 0.3
        self.superview?.addSubview(shadow)
        self.superview?.sendSubview(toBack: shadow)
    }
    
    func setGradient(color1: UIColor, color2: UIColor, frame: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = frame
        self.layer.sublayers?.insert(gradientLayer, at: 0)
    }
    
    var graidentImage: UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.motivColor.baseColor.color().cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: currentContext)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func fadeIn(duration: TimeInterval = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}

class Slider : UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}

