//
//  DiStorage_UITests.swift
//  DiStorage_UITests
//
//  Created by Алексей Попков on 16.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import DiStorage

final class DiStorage_UITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    
        let loginPage = LoginPage()
        
        loginPage.checkInitialState()
        XCTAssert(loginPage.loginButton.isEnabled == false)
        
        loginPage.nameTextField.tap()
        loginPage.nameTextField.typeText("login")
        XCTAssert(loginPage.loginButton.isEnabled == false)
        loginPage.passwordTextField.tap()
        loginPage.passwordTextField.typeText("password")
        XCTAssert(loginPage.loginButton.isEnabled == true)
        
        loginPage.loginButton.tap()
        
        XCTAssert(loginPage.loadingIndicator.exists)
        
//        XCTAssert(DiStorage.shared.canResolve(LoginUsecase.self))
        
        let homePage = HomePage()
        
        homePage.view.waitForAppear()
        
        homePage.checkInitialState()
        XCTAssert(homePage.view.exists)
        
        homePage.doSomethingButton.tap()
        
        loginPage.loadingIndicator.waitForDisappear()
        
        XCTAssert(loginPage.loadingIndicator.exists == false)
        
        homePage.logoutButton.tap()
        
        loginPage.view.waitForAppear()
        
        XCTAssert(loginPage.view.exists)
        XCTAssert(loginPage.titleLabel.exists)
        XCTAssert(loginPage.descriptionLabel.exists)
        XCTAssert(loginPage.nameTextField.exists)
        XCTAssert(loginPage.passwordTextField.exists)
        XCTAssert(loginPage.loginButton.exists)
        XCTAssert(loginPage.loginButton.isEnabled == false)
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

