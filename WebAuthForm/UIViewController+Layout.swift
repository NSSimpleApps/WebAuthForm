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
    public func placeSubview(_ subView: UIView, withInsets insets: UIEdgeInsets) {
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(subView)
        
        let leadingConstraint =
            NSLayoutConstraint(item: view,
                               attribute: .leadingMargin,
                               relatedBy: .equal,
                               toItem: subView,
                               attribute: .leading,
                               multiplier: 1,
                               constant: -insets.left)
        let trailingConstraint =
            NSLayoutConstraint(item: view,
                               attribute: .trailingMargin,
                               relatedBy: .equal,
                               toItem: subView,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: insets.right)
        let topConstraint =
            NSLayoutConstraint(item: subView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: topLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: insets.top)
        let bottomConstraint =
            NSLayoutConstraint(item: bottomLayoutGuide,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: subView,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: insets.bottom)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
