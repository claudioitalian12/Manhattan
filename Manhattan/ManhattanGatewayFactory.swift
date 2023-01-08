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

struct ManhattanGatewayFactory {
    func getManhattanLoginGateway() -> any ManhattanGatewayProtocol {
        ManhattanLoginGateway(
            childGateway: nil,
            gatewayType: .login
        )
    }
    
    func getManhattanSignUpGateway() -> any ManhattanGatewayProtocol {
        ManhattanSignUpGateway(
            childGateway: nil,
            gatewayType: .signUp
        )
    }
    
    func getManhattanHomeGateway() -> any ManhattanGatewayProtocol {
        ManhattanHome(
            childGateway: nil,
            gatewayType: .home
        )
    }
}
