//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 10/12/22.
//

enum SignUpButtonType: CaseIterable {
    case home
    case login
    
    var rawValue: String {
        switch self {
        case .home:
            return "signUpView_button_home".localized
        case .login:
            return "signUpView_button_back".localized
        }
    }
}
