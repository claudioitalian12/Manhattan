import SwiftUI

public protocol ManhattanGatewayProtocol: AnyObject {
    var childGateway: [any ManhattanGatewayProtocol]? { get set }
    var gatewayType: GatewayType { get set }
    func start() -> AnyView
}
