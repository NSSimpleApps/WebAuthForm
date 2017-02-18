//
//  AppDelegate.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 15.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - properties
    var window: UIWindow?

    // MARK: - `UIApplicationDelegate` conformance
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = RootViewController.rootViewController
        self.window?.makeKeyAndVisible()
                
        return true
    }
}

