//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 18/12/22.
//

import Foundation

// MARK: Date
public extension Date {
    /// format as abbreviated day.
    func formatAsAbbreviatedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(
            from: self
        )
    }
    /// format as abbreviated time.
    func formatAsAbbreviatedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(
            from: self
        )
    }
    /// seven days out.
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(
            byAdding: .day,
            value: 7,
            to: self
        ) ?? self
    }
    /// thirty days out.
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(
            byAdding: .day,
            value: 30,
            to: self
        ) ?? self
    }
}
