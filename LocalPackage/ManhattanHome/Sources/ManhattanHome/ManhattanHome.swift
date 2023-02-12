import SwiftUI
import ManhattanCore

// MARK: ManhattanHome
public class ManhattanHome: ManhattanGatewayProtocol {
    /// homeCoordinator.
    private let homeCoordinator: any ManhattanHomeCoordinatorProtocol = ManhattanHomeCoordinator()
    /// gateway type.
    public var gatewayType: GatewayType
    /**
        Init.

        - Parameter gatewayType: gateway type.
    */
    public init(
        gatewayType: GatewayType
    ) {
        self.gatewayType = gatewayType
        homeCoordinator.parentGateway = self
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        homeCoordinator.start()
    }
}
