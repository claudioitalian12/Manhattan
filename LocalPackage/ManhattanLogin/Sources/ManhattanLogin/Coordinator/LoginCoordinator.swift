//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import SwiftUI
import ManhattanCore

protocol LoginCoordinatorProtocol: ManhattanCoordinatorProtocol {}

class LoginCoordinator: LoginCoordinatorProtocol, ObservableObject {
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
            LoginView(
                viewModel: LoginFactory().getLoginViewModel(
                    userService: RealmUserService()
                )
            )
        )
    }
}
