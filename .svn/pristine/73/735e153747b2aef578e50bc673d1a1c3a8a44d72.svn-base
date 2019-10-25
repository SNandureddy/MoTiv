//
//  String.swift
//  Lens App
//
//  Created by Apple on 13/08/18.
//  Copyright © 2018 Deftsoft. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    var amountValue: String {
        return "£\(self)"
    }
    
    
    //MARK: Validations
    var isValidEmail: Bool {
        let emailRegEx = kEmailCheck
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.lowercased())
    }
    
    var isValidPassword: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 6 ? true: false
    }
    
    var isValidData: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 ?  true: false
    }
    
    var isValidPhone: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 8 ? true: false
    }
    
    var isValidCardNumber: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 8 ? true: false
    }
    
    var isValidCVV: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 ? true: false
    }
    
    var isValidAccountNumber: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 7 ? true: false
    }
    
    var isValidBSBNumber: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).count >= 3 ? true: false
    }
    
    var isValidURL: Bool {
        if let url = URL(string: self) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }

}
