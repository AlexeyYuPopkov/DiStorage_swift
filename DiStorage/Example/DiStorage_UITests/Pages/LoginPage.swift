//
//  LoginPage.swift
//  DiStorage_UITests
//
//  Created by Алексей Попков on 17.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest

struct LoginPage {
    private let app = XCUIApplication()
    
    var view: XCUIElement {
        return app.findBy(type: .other, identifier: "LoginVC")
    }
    
    var titleLabel: XCUIElement {
        return view.findBy(type: .staticText, identifier: "TitleLabel.AccessibilityId")
    }
    var descriptionLabel: XCUIElement {
        return view.findBy(type: .staticText, identifier: "DescriptionLabel.AccessibilityId")
    }
    var nameTextField: XCUIElement {
        return view.findBy(type: .textField, identifier: "NameTextField.AccessibilityId")
    }
    var passwordTextField: XCUIElement {
        return view.findBy(type: .textField, identifier: "PasswordTextField.AccessibilityId")
    }
    var loginButton: XCUIElement {
        return view.findBy(type: .button, identifier: "SendButton.AccessibilityId")
    }
    
    var loadingIndicator: XCUIElement {
        return view.findBy(type: .other, identifier: "LoadingIndicator")
    }
    
    func checkInitialState() {
        XCTAssert(view.exists)
        XCTAssert(titleLabel.exists)
        XCTAssert(descriptionLabel.exists)
        XCTAssert(nameTextField.exists)
        XCTAssert(passwordTextField.exists)
        XCTAssert(loginButton.exists)
    }
}
