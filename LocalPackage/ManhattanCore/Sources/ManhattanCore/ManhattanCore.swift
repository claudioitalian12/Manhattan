import SwiftUI

// MARK: ManhattanGatewayProtocol
public protocol ManhattanGatewayProtocol: AnyObject {
    /// gateway type.
    var gatewayType: GatewayType { get set }
    /// start.
    func start() -> AnyView
}
