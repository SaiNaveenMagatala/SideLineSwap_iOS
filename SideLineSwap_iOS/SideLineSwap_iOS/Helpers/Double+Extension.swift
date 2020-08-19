//
//  Double+Extension.swift
//  SideLineSwap_iOS
//
//  Created by Naveen Magatala on 8/19/20.
//  Copyright © 2020 Naveen Magatala. All rights reserved.
//

import Foundation

extension Double {
    var dropTrailingZeroes: String {
        String(format: "%g", self)
    }
}
