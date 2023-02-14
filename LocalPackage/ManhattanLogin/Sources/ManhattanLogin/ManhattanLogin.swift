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
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        AnyView(
            LoginView(
                viewModel: LoginFactory().getLoginViewModel(
                    userService: RealmUserService()
                )
            )
        )
    }
}
