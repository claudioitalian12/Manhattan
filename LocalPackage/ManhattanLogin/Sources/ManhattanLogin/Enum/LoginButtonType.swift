//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 07/12/22.
//

// MARK: LoginButtonType
enum LoginButtonType: CaseIterable {
    /// home
    case home
    /// signup
    case signup
    /// raw value
    var rawValue: String {
        switch self {
        case .home:
            return "loginView_button_login".localized
        case .signup:
            return "loginView_button_signin".localized
        }
    }
}
