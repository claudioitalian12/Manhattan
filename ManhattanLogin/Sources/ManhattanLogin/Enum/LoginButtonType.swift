//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 07/12/22.
//

enum LoginButtonType: CaseIterable {
    case home
    case signup
    
    var rawValue: String {
        switch self {
        case .home:
            return "loginView_button_login".localized
        case .signup:
            return "loginView_button_signin".localized
        }
    }
}
