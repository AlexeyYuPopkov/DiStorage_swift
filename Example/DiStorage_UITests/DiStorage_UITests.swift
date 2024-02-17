//
//  DiStorage_UITests.swift
//  DiStorage_UITests
//
//  Created by Алексей Попков on 16.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest

final class DiStorage_UITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        let titleLabel = app.findBy(type: .staticText, identifier: "LoginVC.TitleLabel.AccessibilityId")
        let descriptionLabel = app.findBy(type: .staticText, identifier: "LoginVC.DescriptionLabel.AccessibilityId")
        let nameTextField = app.findBy(type: .textField, identifier: "LoginVC.NameTextField.AccessibilityId")
        let passwordTextField = app.findBy(type: .textField, identifier: "LoginVC.PasswordTextField.AccessibilityId")
        let loginButton = app.findBy(type: .button, identifier: "LoginVC.SendButton.AccessibilityId")

        XCTAssert(titleLabel.exists)
        XCTAssert(descriptionLabel.exists)
        XCTAssert(nameTextField.exists)
        XCTAssert(passwordTextField.exists)
        XCTAssert(loginButton.exists)
        
        
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
//XCUIElementTypeTextField
extension XCUIApplication {
    func findBy(type: XCUIElement.ElementType, identifier: String) -> XCUIElement {
        return self.descendants(matching: type)
            .matching(NSPredicate(format: "identifier == '\(identifier)'"))
            .element
    }
}
