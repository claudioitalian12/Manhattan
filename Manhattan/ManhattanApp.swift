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

@main
struct ManhattanApp: App {
    let gatewatFactory = ManhattanGatewayFactory()
    @ObservedObject var appEnvironment = AppEnvironment.defaultValue

    init() { }
    
    var body: some Scene {
        setupManhattanView()
    }
    
    private func setupManhattanView() -> some Scene {
        WindowGroup {
            getAppView()
        }
    }
    
    @ViewBuilder
    private func getAppView() -> some View {
        switch appEnvironment.gateway {
        case .login:
            gatewatFactory.getManhattanLoginGateway().start()
        case .signUp:
            gatewatFactory.getManhattanSignUpGateway().start()
        case .home:
            gatewatFactory.getManhattanHomeGateway().start()
        }
    }
}
