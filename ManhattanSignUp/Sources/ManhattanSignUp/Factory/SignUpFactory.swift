//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import ManhattanCore

struct SignUpFactory {
    func getSignUpViewModel(
        userService: UserService?
    ) -> SignUpViewModel {
        SignUpViewModel(
            userService: userService
        )
    }
}
