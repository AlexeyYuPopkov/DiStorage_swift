//
//  OnRouteProtocol.swift
//  DiStorage_Example
//
//  Created by Alexey Popkov on 08.01.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

protocol OnRouteProtocol {
    associatedtype Route
    /// if  [onRoute] will setup to UIViewController than  [onRoute]  should capture [self] (without [weak] keyword) to implicitly maintain router
    var onRoute: ((Route) -> Void)? { get set }
}
