//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 17/12/22.
//

import ManhattanCore
import SwiftUI

// MARK: ManhattanHomeCoordinatorProtocol
protocol ManhattanHomeCoordinatorProtocol: ManhattanCoordinatorProtocol {
}

// MARK: ManhattanHomeCoordinator
class ManhattanHomeCoordinator: ManhattanHomeCoordinatorProtocol {
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
    /// start.
    @ViewBuilder
    func start() -> AnyView {
        AnyView(
            HomeView(
                viewModel: HomeFactory().getHomeViewModel()
            )
        )
    }
}

