//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 11/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanSignUp

final class SignUpButtonTypeTests: XCTestCase {
    var signUpButtonType: SignUpButtonType?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpButtonType = .home
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signUpButtonType = nil
    }
    
    func testButtonTypeHome() throws {
        var signUpButtonType = try XCTUnwrap(self.signUpButtonType)
        signUpButtonType = .home
        XCTAssertEqual(
            signUpButtonType.rawValue,
            "signUpView_button_home".localized
        )
    }
}
