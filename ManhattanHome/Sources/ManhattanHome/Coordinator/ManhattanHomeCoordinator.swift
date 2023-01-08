//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 17/12/22.
//

import ManhattanCore
import SwiftUI

protocol ManhattanHomeCoordinatorProtocol: ManhattanCoordinatorProtocol {
}

class ManhattanHomeCoordinator: ManhattanHomeCoordinatorProtocol {
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
            HomeView(
                viewModel: HomeFactory().getHomeViewModel()
            )
        )
    }
}

