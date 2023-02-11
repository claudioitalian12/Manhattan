//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import SwiftUI

// MARK: ManhattanCoordinatorProtocol
public protocol ManhattanCoordinatorProtocol: AnyObject {
    /// parent gateway
    var parentGateway: (any ManhattanGatewayProtocol)? { get set }
    /// child coordinator
    var childCoordinator: [any ManhattanCoordinatorProtocol]? { get set }
    /// start
    func start() -> AnyView
}
