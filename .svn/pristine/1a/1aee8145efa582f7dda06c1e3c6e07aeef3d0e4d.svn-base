//
//  UITableView.swift
//  MoTiv
//
//  Created by Apple on 07/02/19.
//  Copyright © 2019 MoTiv. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}

