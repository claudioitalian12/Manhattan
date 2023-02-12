import SwiftUI
import ManhattanCore

// MARK: ManhattanSignUpGateway
public class ManhattanSignUpGateway: ManhattanGatewayProtocol {
    /// signup coordinator.
    private let signUpCoordinator: any SignUpCoordinatorProtocol = SignUpCoordinator()
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter gatewayType: gateway.
    */
    public init(
        gatewayType: GatewayType
    ) {
        self.gatewayType = gatewayType
        signUpCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        signUpCoordinator.start()
    }
}
