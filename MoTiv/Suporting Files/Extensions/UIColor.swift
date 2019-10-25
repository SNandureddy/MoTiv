//
//  UIColor.swift
//  MoTiv
//
//  Created by Apple on 16/11/17.
//  Copyright © 2017 Deftsfot. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    enum motivColor  {
        
        case baseColor
        case darkBaseColor
        case instagramColor //38668c
        
        func color(alpha: CGFloat = 1.0) -> UIColor {
            var colorToReturn:UIColor?
            switch self {
            case .baseColor:
                colorToReturn = UIColor(red: 220/255, green: 203/255, blue: 125/255, alpha: alpha)
                
            case .darkBaseColor:
                colorToReturn = UIColor(red: 190/255, green: 166/255, blue: 85/255, alpha: alpha)
                
            case.instagramColor:
                colorToReturn = UIColor(red:0.22, green:0.40, blue:0.55, alpha:1.0)
            }
            return colorToReturn!
        }
    }
    
    //TO REMOVE THE NAVIGATION BAR LINE
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}



