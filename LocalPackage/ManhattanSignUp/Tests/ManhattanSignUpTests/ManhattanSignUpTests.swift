import XCTest
import ManhattanCore
@testable import ManhattanSignUp

final class ManhattanSignUpTests: XCTestCase {
    var manhattanGateway: ManhattanGatewayProtocol?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manhattanGateway = ManhattanSignUpGateway(
            gatewayType: .signUp
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manhattanGateway = nil
    }
    
    func testManhattanSignUpGatewayStart() throws {
        let manhattanGateway = try XCTUnwrap(
            self.manhattanGateway
        )
        _ = manhattanGateway.start()
    }
    
    func testManhattanGatewayType() throws {
        let manhattanGateway = try XCTUnwrap(
            self.manhattanGateway
        )
        let gatewayType = manhattanGateway.gatewayType
        XCTAssertEqual(gatewayType, .signUp)
    }
}
