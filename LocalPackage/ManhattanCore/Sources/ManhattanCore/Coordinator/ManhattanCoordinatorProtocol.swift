//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 04/12/22.
//

import SwiftUI

public protocol ManhattanCoordinatorProtocol: AnyObject {
    var parentGateway: (any ManhattanGatewayProtocol)? { get set }
    var childCoordinator: [any ManhattanCoordinatorProtocol]? { get set }
    func start() -> AnyView
}
