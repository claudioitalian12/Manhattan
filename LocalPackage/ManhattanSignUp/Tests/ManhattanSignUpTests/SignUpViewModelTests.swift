//
//  File.swift
//  
//
//  Created by Claudio Cavalli on 11/12/22.
//

import XCTest
import SwiftUI
@testable import ManhattanCore
@testable import ManhattanSignUp

final class SignUpViewModelTests: XCTestCase {
    var signUpViewModel: SignUpViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signUpViewModel = SignUpViewModel(
            userService: RealmUserService()
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signUpViewModel = nil
    }
    
    func testSignUpViewData() throws {
        let signUpViewModel = try XCTUnwrap(self.signUpViewModel)
        
        XCTAssertEqual(signUpViewModel.username, "")
        XCTAssertEqual(signUpViewModel.password, "")
    }
}
