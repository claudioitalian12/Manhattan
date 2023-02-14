import SwiftUI
import ManhattanCore

// MARK: ManhattanHome
public class ManhattanHome: ManhattanGatewayProtocol {
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
    }
    /// start.
    @ViewBuilder
    public func start() -> AnyView {
        AnyView(
            HomeView(
                viewModel: HomeFactory().getHomeViewModel()
            )
        )
    }
}
