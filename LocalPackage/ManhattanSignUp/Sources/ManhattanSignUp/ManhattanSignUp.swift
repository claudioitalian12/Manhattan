import SwiftUI
import ManhattanCore

// MARK: ManhattanSignUpGateway
public class ManhattanSignUpGateway: ManhattanGatewayProtocol {
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
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        AnyView(
            SignUpView(
                viewModel: SignUpFactory().getSignUpViewModel(
                    userService: RealmUserService()
                )
            )
        )
    }
}
