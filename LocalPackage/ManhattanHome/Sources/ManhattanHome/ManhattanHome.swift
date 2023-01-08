import SwiftUI
import ManhattanCore

public class ManhattanHome: ManhattanGatewayProtocol {
    private let homeCoordinator: any ManhattanHomeCoordinatorProtocol = ManhattanHomeCoordinator()
    public var childGateway: [any ManhattanGatewayProtocol]?
    public var gatewayType: GatewayType
    
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        homeCoordinator.parentGateway = self
    }
    
    @ViewBuilder
    public func start() -> AnyView {
        homeCoordinator.start()
    }
}
