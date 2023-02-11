//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import ManhattanCore

// MARK: SignUpFactory
struct SignUpFactory {
    /**
        Get signup view model.

        - Parameter userService: user service.
    */
    func getSignUpViewModel(
        userService: UserServiceProtocol?
    ) -> SignUpViewModel {
        SignUpViewModel(
            userService: userService
        )
    }
}
