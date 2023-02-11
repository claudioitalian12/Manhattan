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
    /// child gateway.
    public var childGateway: [any ManhattanGatewayProtocol]?
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter childGateway: child gateway.
        - Parameter gatewayType: gateway type.
    */
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        loginCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        loginCoordinator.start()
    }
}
