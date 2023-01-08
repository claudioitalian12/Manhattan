import XCTest
import ManhattanCore
@testable import ManhattanSignUp

final class ManhattanSignUpTests: XCTestCase {
    var manhattanGateway: ManhattanGatewayProtocol?
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manhattanGateway = ManhattanSignUpGateway(
            childGateway: [ManhattanSignUpGateway(
                childGateway: nil,
                gatewayType: .home
            )],
            gatewayType: .signUp
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manhattanGateway = nil
    }
    
    func testManhattanSignUpGatewayStart() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        _ = manhattanGateway.start()
    }
    
    func testManhattanDestinationViewExist() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        let destinationView = manhattanGateway.getDestionView(gatewayType: .home)
        XCTAssertNotNil(destinationView)
    }
    
    func testManhattanDestinationViewNotExist() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        manhattanGateway.childGateway = nil
        let destinationView = manhattanGateway.getDestionView(gatewayType: .home)
        XCTAssertNil(destinationView)
    }
}
