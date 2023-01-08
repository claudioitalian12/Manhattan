//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 11/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanSignUp

final class SignUpFieldTypeTests: XCTestCase {
    var signUpFieldType: SignUpFieldType?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpFieldType = .username
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signUpFieldType = nil
    }
    
    func testSignUpField() throws {
        _ = try XCTUnwrap(self.signUpFieldType)
    }
}
