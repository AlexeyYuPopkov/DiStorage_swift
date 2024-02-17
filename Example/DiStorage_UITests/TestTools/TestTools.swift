//
//  TestTools.swift
//  DiStorage_UITests
//
//  Created by Алексей Попков on 17.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest

extension XCUIElement {
    func findBy(type: XCUIElement.ElementType, identifier: String?) -> XCUIElement {
        if let identifier {
            return self.descendants(matching: type)
                .matching(NSPredicate(format: "identifier == '\(identifier)'"))
                .element
        } else {
            return self.descendants(matching: type)
                .element
        }
    }
    
    
}
// MARK: - wait
extension XCUIElement {
    static let defaultTimeout = TimeInterval(20)
    
    @discardableResult
    func waitForAppear(timeout: TimeInterval = defaultTimeout) -> XCTWaiter.Result {
        return waitForPredicateExpectation(predicate: NSPredicate(format: "exists == 1"),
                                           timeout: timeout)
    }
    
    @discardableResult
    func waitForDisappear(timeout: TimeInterval = defaultTimeout) -> XCTWaiter.Result {
        return waitForPredicateExpectation(predicate: NSPredicate(format: "exists == 0"),
                                           timeout: timeout)
    }
    
    @discardableResult
    func waitForPredicateExpectation(
        predicate: NSPredicate,
        timeout: TimeInterval = defaultTimeout
    ) -> XCTWaiter.Result {
        let expectation = XCTNSPredicateExpectation(predicate: predicate,
                                                    object: self)
        return XCTWaiter().wait(for: [expectation],
                                timeout: timeout)
    }
}
