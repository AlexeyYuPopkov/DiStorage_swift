//
//  AuthDiScope.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import DiStorage

final class AuthDiScope: DiScope {
    func bind(di: DiStorage) {

        di.bind(
            interface: DoSomethingRepository.self,
            lifeTime: .weakSingle,
            scope: self
        ) {
            DoSomethingRepositoryImpl()
        }
        
        bindUsecases(di)
    }
}

// MARK: - Private

extension AuthDiScope {
    private func bindUsecases(_ di: DiStorage) {
        di.bind(
            interface: LogoutUsecase.self,
            lifeTime: .prototype,
            scope: self
        ) {
            LogoutUsecase(
                tokenRepository: di.resolve()
            )
        }

        di.bind(
            interface: DoSomethingUsecase.self,
            lifeTime: .prototype,
            scope: self
        ) {
            DoSomethingUsecase(
                repository: di.resolve()
            )
        }
    }
}


