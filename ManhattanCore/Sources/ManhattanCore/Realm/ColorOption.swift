//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import SwiftUI

public enum ColorOptions: String, CaseIterable {
    public typealias RawValue = String
    
    case primary = "primary"
    case gray = "gray"
    case red = "red"
    case orange = "orange"
    case yellow = "yellow"
    case green = "green"
    case mint = "mint"
    case cyan = "cyan"
    case indigo = "indigo"
    case purple = "purple"
    
    public var color: Color {
        switch self {
        case .primary:
            return .primary
        case .gray:
            return .gray
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .mint:
            return .mint
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .purple:
            return .purple
        }
    }
    
    public static var randomColor: Color {
        if let element = ColorOptions.allCases.randomElement() {
            return element.color
        } else {
            return ColorOptions.primary.color
        }
    }
}
