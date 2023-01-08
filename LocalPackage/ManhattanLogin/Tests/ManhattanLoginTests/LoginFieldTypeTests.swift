//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 07/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanLogin

final class LoginFieldTypeTests: XCTestCase {
    var loginFieldType: LoginFieldType?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginFieldType = .username
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginFieldType = nil
    }
    
    func testLoginField() throws {
        _ = try XCTUnwrap(self.loginFieldType)
    }
}
