//
//  DiStorage.swift
//  SBF
//
//  Created by Alexey Popkov on 31.08.2023.
//

import Foundation

public protocol DiStorageProtocol {
    func bind<Interface, Instance: AnyObject>(
        interface: Interface.Type,
        lifeTime: DiStorageLifeTime,
        scope: Any?,
        constructor: @escaping (() -> Instance))

    func resolve<Interface>() -> Interface

    func tryResolve<Interface>(_ interface: Interface.Type) -> Interface?

    func remove(scope: Any.Type)

    func removeAll()
}

public final class DiStorage: DiStorageProtocol {
    private lazy var instances = Dictionary<String, DiInstanceBox>()

    private lazy var _tagsMap = Dictionary<String, Set<String>>()

    public init() {}

    static public let shared = DiStorage()
}

// MARK: - Public

extension DiStorage {
    public func bind<Interface, Instance: AnyObject>(
        interface: Interface.Type,
        lifeTime: DiStorageLifeTime,
        scope: Any?,
        constructor: @escaping (() -> Instance)) {
        let name = String(reflecting: interface)
        let tagName = scope == nil ? nil : String(reflecting: scope!)

        bind(for: name,
             tagName: tagName,
             lifeTime: lifeTime,
             constructor: constructor)
    }

    public func resolve<Interface>() -> Interface {
        let name = String(reflecting: Interface.self)
        return resolve(for: name) as! Interface
    }
    
    public func canResolve<Interface>(_ interface: Interface.Type) -> Bool {
        return tryResolve(interface) != nil
    }

    public func tryResolve<Interface>(_ interface: Interface.Type) -> Interface? {
        let name = String(reflecting: interface)
        let result = tryResolve(for: name) as? Interface
        return result
    }
    
    public func remove<Interface>(_ interface: Interface.Type) {
        let name = String(reflecting: interface)
        instances.removeValue(forKey: name)
    }

    public func remove(scope: Any.Type) {
        let tagName = String(reflecting: scope)
        if let names = _tagsMap[tagName], names.isEmpty == false {
            names.forEach { name in
                removeInstanceForName(name)
            }

            _tagsMap.removeValue(forKey: tagName)
        }
    }

    public func removeAll() {
        instances.removeAll()
    }
}

// MARK: Private

extension DiStorage {
    private func bind<Instance: AnyObject>(for name: String,
                                           tagName: String?,
                                           lifeTime: DiStorageLifeTime,
                                           constructor: @escaping (() -> Instance)) {
        let result: DiInstanceBox

        if let tagName = tagName, tagName.isEmpty == false {
            if var tags = _tagsMap[tagName] {
                tags.insert(name)
                _tagsMap[tagName] = tags
            } else {
                _tagsMap[tagName] = .init([name])
            }
        }

        switch lifeTime {
        case .strongSingle:
            result = StrongInstance(constructor: constructor)
        case .weakSingle:
            result = WeakInstance(constructor: constructor)
        case .prototype:
            result = Prototype(constructor: constructor)
        }

        registerInstance(instance: result, for: name)
    }

    private func resolve(for name: String) -> Any {
        let box = instances[name]

        let result = box!.instance!

        if let box = box as? WeakInstance {
            box._instance = result
        }

        return result
    }

    private func tryResolve(for name: String) -> Any? {
        guard let box = instances[name] else {
            return nil
        }

        let result = box.instance

        if let box = box as? WeakInstance {
            box._instance = result
        }

        return result
    }

    private func removeInstanceForName(_ name: String) {
        _ = instances.removeValue(forKey: name)
    }
}

// MARK: Private

extension DiStorage {
    private func registerInstance(instance: DiInstanceBox,
                                  for name: String) {
        instances[name] = instance
    }

    private func registeredInstance(for name: String) -> DiInstanceBox? {
        guard let result = instances[name] else {
            return nil
        }

        return result
    }
}
