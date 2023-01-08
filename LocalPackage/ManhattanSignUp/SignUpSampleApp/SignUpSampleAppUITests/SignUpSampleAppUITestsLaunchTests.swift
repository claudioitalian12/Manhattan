//
//  SignUpSampleAppUITestsLaunchTests.swift
//  SignUpSampleAppUITests
//
//  Created by Claudio Cavalli on 09/12/22.
//

import XCTest

final class SignUpSampleAppUITestsLaunchTests: XCTestCase {
    var app = XCUIApplication()
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunch() throws {
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testTapButtonPushSignUp() throws {
        app.buttons["push signUp"].tap()
    }
    
    func testTapButtonSignUPLogin() throws {
        app.buttons["push signUp"].tap()
        app.buttons["Login"].tap()
    }
    
    func testTapButtonSignUPBack() throws {
        app.buttons["push signUp"].tap()
        app.navigationBars.buttons["Back"].tap()
    }
    
    func testInsertUserName() throws {
        app.buttons["push signUp"].tap()
        app.tap()
        let username = app.textFields["Username"]
        XCTAssertTrue(username.waitForExistence(timeout: 2.0))
        username.tap()
        username.typeText("testemail@realm.com")

        let usernameValue = try XCTUnwrap(username.value as? String)
        
        XCTAssertEqual(usernameValue, "testemail@realm.com")
    }
    
    func testInsertPassword() throws {
        app.buttons["push signUp"].tap()
        
        let password = app.secureTextFields["Password minimum 6 characters"]
        XCTAssertTrue(password.waitForExistence(timeout: 1.0))
        password.tap()
        password.typeText("myPassword")

        let passwordValue = try XCTUnwrap(password.value as? String)
        
        XCTAssertEqual(passwordValue, "••••••••••")
    }
}
