//
//  HomePage.swift
//  DiStorage_UITests
//
//  Created by Алексей Попков on 17.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest

struct HomePage {
    private let app = XCUIApplication()
    
    var view: XCUIElement {
        return app.findBy(type: .other, identifier: "HomeVC.AccessibilityId")
    }
    
    var label: XCUIElement {
        return app.findBy(type: .staticText, identifier: "Label.AccessibilityId")
    }
    
    var doSomethingButton: XCUIElement {
        return view.findBy(type: .button, identifier: "DoSomethingButton.AccessibilityId")
    }
    
    var logoutButton: XCUIElement {
        return view.findBy(type: .button, identifier: "SendButton.AccessibilityId")
    }
    
    var loadingIndicator: XCUIElement {
        return view.findBy(type: .other, identifier: "LoadingIndicator")
    }
    
    func checkInitialState() {
        XCTAssert(label.exists)
        XCTAssert(doSomethingButton.isEnabled)
        XCTAssert(doSomethingButton.exists)
        XCTAssert(logoutButton.isEnabled)
        XCTAssert(logoutButton.exists)
    }
}
