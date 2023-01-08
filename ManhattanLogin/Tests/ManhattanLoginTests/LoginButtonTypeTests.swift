//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 07/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanLogin

final class LoginButtonTypeTests: XCTestCase {
    var loginButtonType: LoginButtonType?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginButtonType = .home
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginButtonType = nil
    }
    
    func testButtonTypeLogin() throws {
        var loginButtonType = try XCTUnwrap(self.loginButtonType)
        loginButtonType = .home
        XCTAssertEqual(
            loginButtonType.rawValue,
            "loginView_button_login".localized
        )
    }
    
    func testButtonTypeSignin() throws {
        var signUpButtonType = try XCTUnwrap(self.loginButtonType)
        signUpButtonType = .signup
        XCTAssertEqual(
            signUpButtonType.rawValue,
            "loginView_button_signin".localized
        )
    }
}
