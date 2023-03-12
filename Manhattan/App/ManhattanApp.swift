//
//  ManhattanApp.swift
//  Manhattan
//
//  Created by Claudio Cavalli on 25/11/22.
//

import ManhattanSignUp
import ManhattanLogin
import ManhattanCore
import SwiftUI

// MARK: ManhattanApp
@main
struct ManhattanApp: App {
    /// gateway.
    let gatewayFactory = ManhattanGatewayFactory()
    /// app environment.
    @ObservedObject var appEnvironment = AppEnvironment.defaultValue
    /// init..
    init() { }
    /// body.
    var body: some Scene {
        setupManhattanView()
    }
    /// setupManhattanView.
    private func setupManhattanView() -> some Scene {
        WindowGroup {
            getAppView(
                gateway: appEnvironment.gateway
            )
        }
    }
    /// get App View.
    @ViewBuilder
    private func getAppView(
        gateway: GatewayType
    ) -> some View {
        getGateway(
            gateway: gateway
        )
        .start()
        .transitionAnimation()
    }
    /// get Gateway.
    private func getGateway(
        gateway: GatewayType
    ) -> any ManhattanGatewayProtocol {
        switch gateway {
        case .login:
            return gatewayFactory
                .getManhattanLoginGateway()
        case .signUp:
            return gatewayFactory
                .getManhattanSignUpGateway()
        case .home:
            return gatewayFactory
                .getManhattanHomeGateway()
        }
    }
}
