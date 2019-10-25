//
//  UIImage.swift
//  Lens App
//
//  Created by Apple on 14/08/18.
//  Copyright © 2018 Deftsoft. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    var imageData: Data {
        return UIImageJPEGRepresentation(self, 0.5)!
    }
}
