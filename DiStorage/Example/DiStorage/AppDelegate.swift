//
//  AppDelegate.swift
//  DiStorage
//
//  Created by 8243302 on 01/08/2024.
//  Copyright (c) 2024 8243302. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
//        UIWindow(windowScene: windowScene)
        let router = RootRouter(window: window)

        window.rootViewController = router.initialVC()
        window.rootViewController?.modalPresentationStyle = .fullScreen
        window.makeKeyAndVisible()
        self.window = window

        if #available(iOS 13.0, *) {
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

