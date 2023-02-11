//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI
import ManhattanCore

// MARK: SignUpCoordinatorProtocol
protocol SignUpCoordinatorProtocol: ManhattanCoordinatorProtocol {
}

// MARK: SignUpCoordinator
class SignUpCoordinator: SignUpCoordinatorProtocol {
    /// parent gateway.
    public weak var parentGateway: (any ManhattanGatewayProtocol)?
    /// child coordinator.
    public var childCoordinator: [any ManhattanCoordinatorProtocol]?
    /**
        Init.

        - Parameter childCoordinator: child coordinator.
    */
    init(
        childCoordinator: [any ManhattanCoordinatorProtocol]? = nil
    ) {
        self.childCoordinator = childCoordinator
    }
    /// start
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
