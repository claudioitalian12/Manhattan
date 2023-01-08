import XCTest
import SwiftUI
@testable import ManhattanCore
@testable import ManhattanLogin

final class ManhattanLoginTests: XCTestCase {
    var manhattanGateway: ManhattanLoginGateway?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manhattanGateway = ManhattanLoginGateway(
            childGateway: [
                ManhattanLoginGateway(
                    childGateway: nil,
                    gatewayType: .signUp
                )
            ],
            gatewayType: .login
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manhattanGateway = nil
    }
    
    func testManhattanLoginGatewayStart() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        _ = manhattanGateway.start()
    }
    
    func testManhattanDestinationViewExist() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        let destinationView = manhattanGateway.getDestionView(gatewayType: .signUp)
        XCTAssertNotNil(destinationView)
    }
    
    func testManhattanDestinationViewNotExist() throws {
        let manhattanGateway = try XCTUnwrap(self.manhattanGateway)
        manhattanGateway.childGateway = nil
        let destinationView = manhattanGateway.getDestionView(gatewayType: .signUp)
        XCTAssertNil(destinationView)
    }
}
