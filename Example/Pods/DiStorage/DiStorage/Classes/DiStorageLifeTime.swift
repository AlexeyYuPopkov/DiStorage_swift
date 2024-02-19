//
//  DiStorageLifeTime.swift
//  SBF
//
//  Created by Alexey Popkov on 06.09.2023.
//

import Foundation

public enum DiStorageLifeTime {
    /// A new instance will be created if it absent in memory, and never will be deinited
    case strongSingle
    /// A new instance will be created if it absent in memory, and will deinited if no strong references
    case weakSingle
    /// A new instance will be created each time
    case prototype
}
