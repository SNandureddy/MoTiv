//
//  Double.swift
//  Lens App
//
//  Created by Apple on 16/08/18.
//  Copyright © 2018 Deftsoft. All rights reserved.
//

import Foundation

extension Double {
    
    var roundToTwoDecimal:String {
        return String(format: "%.2f", self)
    }
    
    var roundValue: Double {
        let multiplier = pow(10, Double(2)) //Upto 2 Decimals
        return Darwin.round(self * multiplier) / multiplier
    }
    var changeToInt:String {
            return String(format: "%.0f", self)
    }
}

extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}

