//
//  File.swift
//
//
//  Created by Claudio Cavalli on 21/12/22.
//

import SwiftUI

// MARK: ColorOptions
public enum ColorOptions: String, CaseIterable {
    /// raw value.
    public typealias RawValue = String
    /// primary.
    case primary = "primary"
    /// gray.
    case gray = "gray"
    /// red.
    case red = "red"
    /// orange.
    case orange = "orange"
    /// yellow.
    case yellow = "yellow"
    /// green.
    case green = "green"
    /// mint.
    case mint = "mint"
    /// cyan.
    case cyan = "cyan"
    /// indigo.
    case indigo = "indigo"
    /// purple.
    case purple = "purple"
    /// color.
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
    /// random color.
    public static var randomColor: Color {
        if let element = ColorOptions.allCases.randomElement() {
            return element.color
        } else {
            return ColorOptions.primary.color
        }
    }
}
