//
//  UITextField.swift
//  Vits Video Calling Interpreter
//
//  Created by Apple on 07/08/17.
//  Copyright © 2017 Deftsoft. All rights reserved.
//

import Foundation
import UIKit

//*** MARK: Validations ***
let kEmailCheck = "[a-z0-9!#$%üäöß&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!üäöß#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
let kAlphaNumericSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890 ")

extension UITextField {
    
    var isEmpty: Bool {
        return self.text?.trimmingCharacters(in: .whitespaces).count == 0 ? true: false
    }
    
    var count: Int {
        return self.text?.count ?? 0
    }
    
    func set(placholder: String? = nil, color: UIColor = UIColor.white, size: CGFloat = 15.0, style: UIFont.MotivFont = UIFont.MotivFont.regular) {
        let myPlaceholder = placholder ?? self.placeholder!
        let attributedString = NSAttributedString(string: myPlaceholder, attributes:[NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: style.fontWithSize(size: size)])
        self.tintColor = color
        self.font = style.fontWithSize(size: size)
        self.attributedPlaceholder = attributedString
    }
    
    //MARK: Validations
    var isValidEmail: Bool {
        let emailRegEx = kEmailCheck
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text!.lowercased())
    }

    var isValidPassword: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 6 ? true: false
    }
    
    var isValidName: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 2 ?  true: false
    }
    
    var isValidPhone: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 8 ? true: false
    }
    
    var isValidCardNumber: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 8 ? true: false
    }
    
    var isValidCVV: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 3 ? true: false
    }
    
    var isValidAccountNumber: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 7 ? true: false
    }
    
    var isValidBSBNumber: Bool {
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0 >= 3 ? true: false
    }
    
    var isValidURL: Bool {
        var url = self.text!
        if (self.text!.range(of: "http") == nil) {
            url = "https://\(url)"
        }
        if let url = URL(string: url) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

}





