//
//  DiModule.swift
//  SBF
//
//  Created by Alexey Popkov on 06.09.2023.
//

import Foundation

public protocol DiScope {
    func bind(di: DiStorage)
}
