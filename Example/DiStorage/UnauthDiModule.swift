//
//  UnauthDiModule.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import DiStorage

final class UnauthDiModule: DiModule {
    func bind(di: DiStorage) {
        di.bind(
            interface: AuthRepository.self,
            lifeTime: .weakSingle,
            tag: self
        ) {
            AuthRepositoryImpl()
        }

        di.bind(
            interface: TokenRepository.self,
            lifeTime: .weakSingle,
            tag: self
        ) {
            TokenRepositoryImpl()
        }

        bindUsecases(di)
    }
}

// MARK: - Private

extension UnauthDiModule {
    private func bindUsecases(_ di: DiStorage) {
        di.bind(
            interface: AuthStatusProviderUsecase.self,
            lifeTime: .strongSingle,
            tag: self
        ) {
            AuthStatusProviderUsecase(
                repository: di.resolve()
            )
        }

        di.bind(
            interface: LoginUsecase.self,
            lifeTime: .prototype,
            tag: self
        ) {
            LoginUsecase(
                authRepository: di.resolve(),
                tokenRepository: di.resolve()
            )
        }
    }
}


