//
//  NumberUtils.swift
//  qpony
//
//  Created by Tomek Rybkowski on 03/10/2020.
//

import Foundation

final class NumberUtils {
    
    static func doubleFormatted(_ double: Double?) -> String {
        guard let double = double else { return "-" }
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 8
        formatter.numberStyle = .decimal
        
        return formatter.string(from: double as NSNumber) ?? "-"
    }
}
