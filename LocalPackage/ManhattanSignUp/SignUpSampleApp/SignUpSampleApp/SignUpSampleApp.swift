//
//  SignUpSampleAppApp.swift
//  SignUpSampleApp
//
//  Created by Claudio Cavalli on 09/12/22.
//

import SwiftUI
import ManhattanCore
import ManhattanSignUp

@main
struct ManhattanApp: App {
    @ObservedObject var appEnvironment = AppEnvironment()
    let signUpView: ManhattanGatewayProtocol = ManhattanSignUpGateway(
        childGateway: nil,
        gatewayType: .signUp
    )
    
    var body: some Scene {
        setupManhattanView()
    }
    private func setupManhattanView() -> some Scene {
        WindowGroup {
            NavigationStack{
                NavigationLink {
                    signUpView.start()
                        .environment(
                            \.appEnvironmentValue,
                             appEnvironment
                        )
                } label: {
                    Text("push signUp")
                }

            }
        }
    }
}
