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
        
        view.addSubview(subView)
        
        let leadingConstraint =
            NSLayoutConstraint(item: self.view!,
                               attribute: .leadingMargin,
                               relatedBy: .equal,
                               toItem: subView,
                               attribute: .leading,
                               multiplier: 1,
                               constant: -insets.left)
        let trailingConstraint =
            NSLayoutConstraint(item: self.view!,
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
                               toItem: self.topLayoutGuide,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: insets.top)
        let bottomConstraint =
            NSLayoutConstraint(item: self.bottomLayoutGuide,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: subView,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: insets.bottom)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
