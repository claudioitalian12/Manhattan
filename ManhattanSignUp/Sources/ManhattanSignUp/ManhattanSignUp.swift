import SwiftUI
import ManhattanCore

public class ManhattanSignUpGateway: ManhattanGatewayProtocol {
    private let signUpCoordinator: any SignUpCoordinatorProtocol = SignUpCoordinator()
    public var childGateway: [any ManhattanGatewayProtocol]?
    public var gatewayType: GatewayType
    
    public init(
        childGateway: [any ManhattanGatewayProtocol]?,
        gatewayType: GatewayType
    ) {
        self.childGateway = childGateway
        self.gatewayType = gatewayType
        signUpCoordinator.parentGateway = self
    }
    
    @ViewBuilder
    public func start() -> AnyView {
        signUpCoordinator.start()
    }
}
