//
//  ManhattanGatewayFactory.swift
//  Manhattan
//
//  Created by Claudio Cavalli on 09/12/22.
//

import ManhattanCore
import ManhattanLogin
import ManhattanSignUp
import ManhattanHome
import SwiftUI

// MARK: ManhattanGatewayFactory
struct ManhattanGatewayFactory {
    /// get Manhattan Login Gateway.
    func getManhattanLoginGateway() -> any ManhattanGatewayProtocol {
        ManhattanLoginGateway(
            childGateway: nil,
            gatewayType: .login
        )
    }
    /// get Manhattan SignUp Gateway.
    func getManhattanSignUpGateway() -> any ManhattanGatewayProtocol {
        ManhattanSignUpGateway(
            childGateway: nil,
            gatewayType: .signUp
        )
    }
    /// get Manhattan Home Gateway.
    func getManhattanHomeGateway() -> any ManhattanGatewayProtocol {
        ManhattanHome(
            childGateway: nil,
            gatewayType: .home
        )
    }
}
