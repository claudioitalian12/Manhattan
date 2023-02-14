//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 07/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanLogin

final class LoginViewModelTests: XCTestCase {
    var loginViewModel: LoginViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginViewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        loginViewModel = nil
    }
    
    func testLoginViewData() throws {
        let loginViewModel = try XCTUnwrap(self.loginViewModel)
        
        XCTAssertEqual(loginViewModel.username, "")
        XCTAssertEqual(loginViewModel.password, "")
    }
}
