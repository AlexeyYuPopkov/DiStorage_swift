//
//  DiStorageTests.swift
//  DiStorage_Tests
//
//  Created by Алексей Попков on 16.02.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import DiStorage

class DiStorageTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        DiStorage.shared.removeAll()
        super.tearDown()
    }
    
    func testBuindingPrototype() {
        bindClassesAsPrototype()
        
        let usecase1_1: Usecase1 = DiStorage.shared.resolve()
        let usecase1_2: Usecase1 = DiStorage.shared.resolve()
        let usecase2_1: Usecase2 = DiStorage.shared.resolve()
        let usecase2_2: Usecase2 = DiStorage.shared.resolve()
        
        let isSameInstanceOfUsecase1 = usecase1_1 === usecase1_2
        XCTAssert(!isSameInstanceOfUsecase1)
        
        let isSameInstanceOfInterface1 = usecase1_1.interface1 === usecase1_2.interface1
        XCTAssert(!isSameInstanceOfInterface1)
        
        let isSameInstanceOfUsecase2 = usecase2_1 === usecase2_2
        XCTAssert(!isSameInstanceOfUsecase2)
    }
    
    func testBuindingStrongSingle() {
        bindClassesAsStrongSingle()
        
        let usecase1_1: Usecase1 = DiStorage.shared.resolve()
        let usecase1_2: Usecase1 = DiStorage.shared.resolve()
        let usecase2_1: Usecase2 = DiStorage.shared.resolve()
        let usecase2_2: Usecase2 = DiStorage.shared.resolve()
        
        let isSameInstanceOfUsecase1 = usecase1_1 === usecase1_2
        XCTAssert(isSameInstanceOfUsecase1)
        
        let isSameInstanceOfInterface1 = usecase1_1.interface1 === usecase1_2.interface1
        XCTAssert(isSameInstanceOfInterface1)
        
        let isSameInstanceOfUsecase2 = usecase2_1 === usecase2_2
        XCTAssert(isSameInstanceOfUsecase2)
    }
    
    func testBuindingWeakSingle() {
        bindClassesAsWeakSingle()
        
        let di = DiStorage.shared
        
        var addressOfInterface1 = ""
        
        let autoreleasepoolExpectation = expectation(description: "Autoreleasepool should drain")

        autoreleasepool {
            var usecase1_1: Usecase1? = di.tryResolve(Usecase1.self)
            var usecase1_2: Usecase1? = di.tryResolve(Usecase1.self)
            
            let isSameInstanceOfUsecase1 = usecase1_1 === usecase1_2
            XCTAssert(isSameInstanceOfUsecase1)
            
            let isSameInstanceOfInterface1 = usecase1_1?.interface1 != nil && usecase1_1?.interface1 === usecase1_2?.interface1
            XCTAssert(isSameInstanceOfInterface1)
            
            addressOfInterface1 = Self.getPointerAsString(usecase1_1?.interface1)
            
            usecase1_1 = nil
            
            let hasInterface1 =
            di.tryResolve(Interface1.self) === usecase1_2?.interface1 &&
            addressOfInterface1 == Self.getPointerAsString(di.tryResolve(Interface1.self))
            
            XCTAssert(hasInterface1 == true)
            
            usecase1_2 = nil
            
            let stillHasInterface1 = addressOfInterface1 == Self.getPointerAsString(di.tryResolve(Interface1.self))
            
            XCTAssert(stillHasInterface1 == true)
            
            autoreleasepoolExpectation.fulfill()
        }
        
        wait(for: [autoreleasepoolExpectation], timeout: 0.0)
        
        let stillHasInterface1 = addressOfInterface1 == Self.getPointerAsString(DiStorage.shared.tryResolve(Interface1.self))
        
        XCTAssert(stillHasInterface1 == false)
    }
    
    func testBuindingCheckTypes() {
        bindClassesAsPrototype()
        let interface1: Interface1 = DiStorage.shared.resolve()
        XCTAssert(interface1 is Interface1Impl)
    }
    
    func testRemoving() {
        bindClassesAsPrototype()
        
        XCTAssert(DiStorage.shared.tryResolve(Interface1.self) != nil)
        XCTAssert(DiStorage.shared.tryResolve(Usecase1.self) != nil)
        XCTAssert(DiStorage.shared.tryResolve(Usecase2.self) != nil)
        
        XCTAssert(DiStorage.shared.canResolve(Interface1.self))
        XCTAssert(DiStorage.shared.canResolve(Usecase1.self))
        XCTAssert(DiStorage.shared.canResolve(Usecase2.self))
        
        DiStorage.shared.remove(Interface1.self)
        DiStorage.shared.remove(Usecase1.self)
        DiStorage.shared.remove(Usecase2.self)
        
        XCTAssert(DiStorage.shared.tryResolve(Interface1.self) == nil)
        XCTAssert(DiStorage.shared.tryResolve(Usecase1.self) == nil)
        XCTAssert(DiStorage.shared.tryResolve(Usecase2.self) == nil)
        
        XCTAssert(DiStorage.shared.canResolve(Interface1.self) == false)
        XCTAssert(DiStorage.shared.canResolve(Usecase1.self) == false)
        XCTAssert(DiStorage.shared.canResolve(Usecase2.self) == false)
    }
}

// MARK: - Tools

extension DiStorageTests {
    private func bindClassesAsPrototype() {
        let di = DiStorage.shared
   
        di.bind(
            interface: Interface1.self,
            lifeTime: .prototype,
            scope: nil,
            constructor: {
                return Interface1Impl()
            }
        )
        
        di.bind(
            interface: Usecase1.self,
            lifeTime: .prototype,
            scope: nil,
            constructor: {
                return Usecase1(interface1: di.resolve())
            }
        )
        
        di.bind(
            interface: Usecase2.self,
            lifeTime: .prototype,
            scope: nil,
            constructor: {
                return Usecase2()
            }
        )
    }
    
    private func bindClassesAsStrongSingle() {
        let di = DiStorage.shared
   
        di.bind(
            interface: Interface1.self,
            lifeTime: .strongSingle,
            scope: nil,
            constructor: {
                return Interface1Impl()
            }
        )
        
        di.bind(
            interface: Usecase1.self,
            lifeTime: .strongSingle,
            scope: nil,
            constructor: {
                return Usecase1(interface1: di.resolve())
            }
        )
        
        di.bind(
            interface: Usecase2.self,
            lifeTime: .strongSingle,
            scope: nil,
            constructor: {
                return Usecase2()
            }
        )
    }
    
    private func bindClassesAsWeakSingle() {
        let di = DiStorage.shared
   
        di.bind(
            interface: Interface1.self,
            lifeTime: .weakSingle,
            scope: nil,
            constructor: {
                return Interface1Impl()
            }
        )
        
        di.bind(
            interface: Usecase1.self,
            lifeTime: .weakSingle,
            scope: nil,
            constructor: {
                return Usecase1(interface1: di.resolve())
            }
        )
    }
    
    static func getPointerAsString(_ object: AnyObject?) -> String {
        guard let object = object else { return "nil" }
        let opaque: UnsafeMutableRawPointer = Unmanaged.passUnretained(object).toOpaque()
        return String(describing: opaque)
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
