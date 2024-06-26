//
//  DoSomethingRepositoryImpl.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

final class DoSomethingRepositoryImpl: DoSomethingRepository {
    func doSomething(completion: @escaping (Result<SomeModel, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            completion(.success(SomeModel()))
        }
    }
}
