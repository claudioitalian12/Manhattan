//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import Foundation

public extension Date {
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
    
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(
            byAdding: .day,
            value: 7,
            to: self
        ) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(
            byAdding: .day,
            value: 30,
            to: self
        ) ?? self
    }
}
