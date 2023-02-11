//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/12/22.
//

// MARK: SignUpButtonType
enum SignUpButtonType: CaseIterable {
    /// home
    case home
    /// login
    case login
    /// rawValue
    var rawValue: String {
        switch self {
        case .home:
            return "signUpView_button_home".localized
        case .login:
            return "signUpView_button_back".localized
        }
    }
}
