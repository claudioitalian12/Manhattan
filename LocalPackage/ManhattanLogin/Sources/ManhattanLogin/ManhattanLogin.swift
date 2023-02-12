//
//  File.swift
//
//
//  Created by Claudio Cavalli on 04/12/22.
//

import ManhattanCore
import WeatherKit
import SwiftUI

// MARK: ManhattanLoginGateway
public class ManhattanLoginGateway: ManhattanGatewayProtocol {
    /// login coordinator.
    private let loginCoordinator: LoginCoordinatorProtocol = LoginCoordinator()
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter gatewayType: gateway type.
    */
    public init(
        gatewayType: GatewayType
    ) {
        self.gatewayType = gatewayType
        loginCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        loginCoordinator.start()
    }
}
