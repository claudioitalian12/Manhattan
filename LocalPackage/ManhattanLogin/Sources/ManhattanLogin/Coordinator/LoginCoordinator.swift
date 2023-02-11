//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import SwiftUI
import ManhattanCore

// MARK: LoginCoordinatorProtocol
protocol LoginCoordinatorProtocol: ManhattanCoordinatorProtocol {}

// MARK: LoginCoordinator
class LoginCoordinator: LoginCoordinatorProtocol, ObservableObject {
    /// parent gateway.
    public weak var parentGateway: (any ManhattanGatewayProtocol)?
    /// child coordinator.
    public var childCoordinator: [any ManhattanCoordinatorProtocol]?
    /**
        Init BoardSubTask with parameters.

        - Parameter childCoordinator: child coordinator.
    */
    init(
        childCoordinator: [any ManhattanCoordinatorProtocol]? = nil
    ) {
        self.childCoordinator = childCoordinator
    }
    /// start.
    @ViewBuilder
    func start() -> AnyView {
        AnyView(
            LoginView(
                viewModel: LoginFactory().getLoginViewModel(
                    userService: RealmUserService()
                )
            )
        )
    }
}
