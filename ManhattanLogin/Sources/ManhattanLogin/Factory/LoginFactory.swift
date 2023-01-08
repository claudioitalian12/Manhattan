//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import ManhattanCore

final class LoginFactory {

    func getLoginViewModel(
        userService: UserService?
    ) -> LoginViewModel {
        LoginViewModel(
            userService: userService
        )
    }
}
