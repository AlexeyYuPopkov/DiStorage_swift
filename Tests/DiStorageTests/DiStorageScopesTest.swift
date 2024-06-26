//
//  DiStorageScopesTest.swift
//  DiStorage_Tests
//
//  Created by Алексей Попков on 16.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import DiStorage

class DiStorageScopesTest: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        DiStorage.shared.removeAll()
        super.tearDown()
    }
    
    func testBuindingAndRemovingScopes() {
        FirstDiScope().bind(di: DiStorage.shared)
        
        checkIfFirstDiScopeBinded();
        
        OtherDiScope().bind(di: DiStorage.shared)
        
        checkIfFirstDiScopeBinded();
        checkIfSecondDiScopeBinded();
        
        DiStorage.shared.remove(scope: OtherDiScope.self)
        
        checkIfFirstDiScopeBinded();
        checkIfSecondDiScopeNotBinded()
        
        DiStorage.shared.remove(scope: FirstDiScope.self)
        
        checkIfFirstDiScopeNotBinded()
        checkIfSecondDiScopeNotBinded()
    }
}

// MARK: - Private
extension DiStorageScopesTest {
    private func checkIfFirstDiScopeBinded() {
        XCTAssert(DiStorage.shared.canResolve(Interface1.self))
        XCTAssert(DiStorage.shared.canResolve(Usecase1.self))
        XCTAssert(DiStorage.shared.canResolve(Usecase2.self))
        
        let interface1: Interface1 = DiStorage.shared.resolve()
        XCTAssert(interface1 is Interface1Impl)
    }
    
    private func checkIfSecondDiScopeBinded() {
        XCTAssert(DiStorage.shared.canResolve(Interface2.self))
        XCTAssert(DiStorage.shared.canResolve(Usecase3.self))
  
        let interface2: Interface2 = DiStorage.shared.resolve()
        XCTAssert(interface2 is Interface2Impl)
    }
    
    private func checkIfSecondDiScopeNotBinded() {
        XCTAssert(DiStorage.shared.canResolve(Interface2.self) == false)
        XCTAssert(DiStorage.shared.canResolve(Usecase3.self) == false)
    }
    
    private func checkIfFirstDiScopeNotBinded() {
        XCTAssert(DiStorage.shared.canResolve(Interface1.self) == false)
        XCTAssert(DiStorage.shared.canResolve(Usecase1.self) == false)
        XCTAssert(DiStorage.shared.canResolve(Usecase2.self) == false)
    }
}

// MARK: - Scopes

class FirstDiScope: DiScope {
    func bind(di: DiStorage) {
        di.bind(
            interface: Interface1.self,
            lifeTime: .strongSingle,
            scope: self,
            constructor: {
                return Interface1Impl()
            }
        )
        
        di.bind(
            interface: Usecase1.self,
            lifeTime: .prototype,
            scope: self,
            constructor: {
                return Usecase1(interface1: di.resolve())
            }
        )
        
        di.bind(
            interface: Usecase2.self,
            lifeTime: .prototype,
            scope: self,
            constructor: {
                return Usecase2()
            }
        )
    }
}

class OtherDiScope: DiScope {
    func bind(di: DiStorage) {
        di.bind(
            interface: Interface2.self,
            lifeTime: .strongSingle,
            scope: self,
            constructor: {
                return Interface2Impl()
            }
        )
        
        di.bind(
            interface: Usecase3.self,
            lifeTime: .prototype,
            scope: self,
            constructor: {
                return Usecase3(interface2: di.resolve())
            }
        )
    }
}

// MARK: - Test classes
fileprivate protocol Interface1: AnyObject {}

fileprivate class Interface1Impl : Interface1 {}

fileprivate class Usecase1 {
    let interface1: Interface1
    
    init(interface1: Interface1) {
        self.interface1 = interface1
    }
}

fileprivate class Usecase2 {}

fileprivate protocol Interface2: AnyObject {}

fileprivate class Interface2Impl : Interface2 {}

fileprivate class Usecase3 {
    let interface2: Interface2
    
    init(interface2: Interface2) {
        self.interface2 = interface2
    }
}

