//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import ManhattanCore

// MARK: LoginFactory
final class LoginFactory {
    /**
        Get login view model.

        - Parameter userService: user service.
    */
    func getLoginViewModel(
        userService: UserServiceProtocol?
    ) -> LoginViewModel {
        LoginViewModel(
            userService: userService
        )
    }
}
