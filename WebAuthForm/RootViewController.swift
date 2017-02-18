//
//  RootViewController.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 16.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit

/// создает `rootViewController` для приложения
open class RootViewController {
    
    // MARK: - private initializer
    private init() {}
    
    // MARK: - properties
    open class var rootViewController: UIViewController {
        
        let viewController = ViewController()
        viewController.edgesForExtendedLayout = .all
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isTranslucent = false
        
        return navigationController
    }
}
