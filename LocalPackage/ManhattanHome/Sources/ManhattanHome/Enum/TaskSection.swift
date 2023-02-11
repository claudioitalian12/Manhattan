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
    case all = "All"
    /// new
    case new = "New"
    /// progress
    case progress = "Progress"
    /// closed
    case closed = "Closed"
}
