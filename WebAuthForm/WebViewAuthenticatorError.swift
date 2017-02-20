//
//  WebViewAuthenticatorError.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 20.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import Foundation

/// ошибка парсинга hash
public enum WebViewAuthenticatorError: Error {
    
    // MARK: cases
    case parseError(tokenKey: String)
    
    // MARK: properties
    var localizedDescription: String {
        
        switch self {
            
        case .parseError(let token):
            
            return "Value for tokenKey: \"\(token)\" cannot be parsed."
        }
    }
}
