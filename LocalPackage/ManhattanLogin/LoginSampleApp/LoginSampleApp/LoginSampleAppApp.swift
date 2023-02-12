//
//  LoginSampleAppApp.swift
//  LoginSampleApp
//
//  Created by Claudio Cavalli on 08/12/22.
//

import SwiftUI
import ManhattanCore
import ManhattanLogin

@main
struct ManhattanApp: App {
    @ObservedObject var appEnvironment = AppEnvironment()
    let loginView: ManhattanGatewayProtocol = ManhattanLoginGateway(
        gatewayType: .login
    )
    
    var body: some Scene {
        setupManhattanView()
    }
    
    private func setupManhattanView() -> some Scene {
        WindowGroup {
            loginView.start()
                .environment(
                    \.appEnvironmentValue,
                     appEnvironment
                )
        }
    }
}
