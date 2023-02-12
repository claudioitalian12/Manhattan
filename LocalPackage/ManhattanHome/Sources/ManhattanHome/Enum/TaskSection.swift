//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 08/01/23.
//

import Foundation

// MARK: TaskSection
enum TaskSection: String, CaseIterable {
    /// all
    case all = "taskView_board_status_all"
    /// new
    case new = "taskView_board_status_new"
    /// progress
    case progress = "taskView_board_status_progress"
    /// closed
    case closed = "taskView_board_status_closed"
    /// localized
    var localized: String {
        self.rawValue.localized
    }
}
