//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI
import ManhattanCore

protocol SignUpCoordinatorProtocol: ManhattanCoordinatorProtocol {
}

class SignUpCoordinator: SignUpCoordinatorProtocol {
    public weak var parentGateway: (any ManhattanGatewayProtocol)?
    public var childCoordinator: [any ManhattanCoordinatorProtocol]?
    
    init(
        childCoordinator: [any ManhattanCoordinatorProtocol]? = nil
    ) {
        self.childCoordinator = childCoordinator
    }
    
    @ViewBuilder
    func start() -> AnyView {
        AnyView(
            SignUpView(
                viewModel: SignUpFactory().getSignUpViewModel(
                    userService: RealmUserService()
                )
            )
        )
    }
}
