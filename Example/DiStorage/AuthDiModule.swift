//
//  UnauthDiModule.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import DiStorage

final class AuthDiModule: DiModule {
    func bind(di: DiStorage) {

        di.bind(
            interface: DoSomethingRepository.self,
            lifeTime: .weakSingle,
            tag: self
        ) {
            DoSomethingRepositoryImpl()
        }
        
        bindUsecases(di)
    }
}

// MARK: - Private

extension AuthDiModule {
    private func bindUsecases(_ di: DiStorage) {
        di.bind(
            interface: LogoutUsecase.self,
            lifeTime: .prototype,
            tag: self
        ) {
            LogoutUsecase(
                tokenRepository: di.resolve()
            )
        }

        di.bind(
            interface: DoSomethingUsecase.self,
            lifeTime: .prototype,
            tag: self
        ) {
            DoSomethingUsecase(
                repository: di.resolve()
            )
        }
    }
}


