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
            getAppView()
        }
    }
    /// getAppView.
    @ViewBuilder
    private func getAppView() -> some View {
        switch appEnvironment.gateway {
        case .login:
            gatewayFactory.getManhattanLoginGateway().start()
                .transitionAnimation()
        case .signUp:
            gatewayFactory.getManhattanSignUpGateway().start()
                .transitionAnimation()
        case .home:
            gatewayFactory.getManhattanHomeGateway().start()
                .transitionAnimation()
        }
    }
}
