import SwiftUI
import ManhattanCore

// MARK: ManhattanHome
public class ManhattanHome: ManhattanGatewayProtocol {
    /// homeCoordinator.
    private let homeCoordinator: any ManhattanHomeCoordinatorProtocol = ManhattanHomeCoordinator()
    /// child Gateway.
    public var childGateway: [any ManhattanGatewayProtocol]?
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter childGateway: child gateway.
        - Parameter gatewayType: gateway type.
    */
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        homeCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        homeCoordinator.start()
    }
}
