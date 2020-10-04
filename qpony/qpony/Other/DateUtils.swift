//
//  DateUtils.swift
//  qpony
//
//  Created by Tomek Rybkowski on 04/10/2020.
//

import UIKit

final class DateUtils {
    
    static func formatDateToString(date: Date, format: String = "yyyy-MM-dd") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dataString = formatter.string(from: date)
        
        return dataString
    }
}
