//
//  UIViewController+Layout.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 16.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit

/// разширение для `UIViewController` для добавления
/// вьюхи с отступами относительно margins по горизонтали
/// и {top,bottom}LayoutGuide по вертикали
public extension UIViewController {
    
    // MARK: service method
    func placeSubview(_ subView: UIView, withInsets insets: UIEdgeInsets) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        let view = self.view!
        view.addSubview(subView)
        let layoutMarginsGuide = view.layoutMarginsGuide
        subView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: insets.left).isActive = true
        subView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -insets.right).isActive = true
        subView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: insets.top).isActive = true
        subView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -insets.bottom).isActive = true
    }
}
