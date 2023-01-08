import ManhattanCore
import WeatherKit
import SwiftUI

public class ManhattanLoginGateway: ManhattanGatewayProtocol {
    private let loginCoordinator: LoginCoordinatorProtocol = LoginCoordinator()
    public var childGateway: [any ManhattanGatewayProtocol]?
    public var gatewayType: GatewayType
    
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        loginCoordinator.parentGateway = self
    }
    
    @ViewBuilder
    public func start() -> AnyView {
        loginCoordinator.start()
    }
}
