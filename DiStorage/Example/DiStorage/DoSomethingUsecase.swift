//
//  DoSomethingUsecase.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

final class DoSomethingUsecase {
   private let repository: DoSomethingRepository

    init(repository: DoSomethingRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<SomeModel, Error>) -> Void) -> Void {
        repository.doSomething(completion: completion)
    }
}
