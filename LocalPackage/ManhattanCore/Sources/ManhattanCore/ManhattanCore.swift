import SwiftUI

// MARK: ManhattanGatewayProtocol
public protocol ManhattanGatewayProtocol: AnyObject {
    /// child gateway.
    var childGateway: [any ManhattanGatewayProtocol]? { get set }
    /// gateway type.
    var gatewayType: GatewayType { get set }
    /// start.
    func start() -> AnyView
}
