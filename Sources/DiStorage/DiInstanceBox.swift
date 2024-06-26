//
//  DiInstanceBox.swift
//  SBF
//
//  Created by Alexey Popkov on 06.09.2023.
//

import Foundation

// MARK: - DiInstanceBox

protocol DiInstanceBox: AnyObject {
    var instance: AnyObject? { get }
    var description: String { get }
    var constructor: () -> AnyObject { get }
}

extension DiInstanceBox {
    static func createWeakInstance(constructor: @escaping () -> AnyObject) {
    }
}

final class WeakInstance: DiInstanceBox {
    let constructor: () -> AnyObject
    weak var _instance: AnyObject?

    var instance: AnyObject? {
        if let result = _instance {
            return result
        } else {
            let result = constructor()
            _instance = result
            return result
        }
    }

    init(constructor: @escaping () -> AnyObject) {
        self.constructor = constructor
    }

    private var name: String {
        return (instance == nil) ? "Undefined Nil" : String(describing: type(of: instance!))
    }

    var description: String {
        return "Weak Instance of Class: \(name)"
    }
}

final class StrongInstance: DiInstanceBox {
    let constructor: () -> AnyObject
    lazy var instance: AnyObject? = constructor()

    init(constructor: @escaping () -> AnyObject) {
        self.constructor = constructor
    }

    private var name: String {
        return (instance == nil) ? "Undefined Nil" : String(describing: type(of: instance!))
    }

    var description: String {
        return "Strong Instance of Class: \(name)"
    }
}

final class Prototype: DiInstanceBox {
    let constructor: () -> AnyObject
    var instance: AnyObject? {
        return constructor()
    }

    init(constructor: @escaping () -> AnyObject) {
        self.constructor = constructor
    }

    private var name: String {
        return (instance == nil) ? "Undefined Nil" : String(describing: type(of: instance!))
    }

    var description: String {
        return "Strong Instance of Class: \(name)"
    }
}
