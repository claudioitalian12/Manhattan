import SwiftUI
import ManhattanCore

// MARK: ManhattanSignUpGateway
public class ManhattanSignUpGateway: ManhattanGatewayProtocol {
    /// signup coordinator.
    private let signUpCoordinator: any SignUpCoordinatorProtocol = SignUpCoordinator()
    /// child gateway.
    public var childGateway: [any ManhattanGatewayProtocol]?
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter childGateway: child gateway.
        - Parameter gatewayType: gateway.
    */
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        signUpCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        signUpCoordinator.start()
    }
}
