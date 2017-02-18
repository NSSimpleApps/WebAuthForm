//
//  WebViewInteractor.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 16.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit
import WebKit

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

/// протокол аутентификации
public protocol WebViewAuthenticatorProtocol: class {
    
    /// вызывается у делегата, когда из hash извлекается значение
    /// с указанным ключом
    func webViewAuthenticator(_ webViewAuthenticator: WebViewAuthenticator,
                              didReceiveToken token: String,
                              inWebView webView: WKWebView)
    
    /// вызывается у делегата адрес ошибочен или hash не может быть
    /// правильно распарсен
    func webViewAuthenticator(_ webViewAuthenticator: WebViewAuthenticator,
                              authDidFailWithError error: Error,
                              inWebView webView: WKWebView)
}

open class WebViewAuthenticator: NSObject {
    
    // MARK: properties
    open var authTokenKey: String = ""
    
    open weak var delegate: WebViewAuthenticatorProtocol?
    
    // MARK: convenience initializer
    convenience public init(authTokenKey: String) {
        
        self.init()
        
        self.authTokenKey = authTokenKey
    }
}

// MARK: `WKNavigationDelegate` conformance
extension WebViewAuthenticator: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        decisionHandler(.allow)
        
        if (navigationAction.navigationType == .other) {
            
            webView.evaluateJavaScript("window.location.hash") { (response: Any?, error: Error?) in
                
                if let hash = response as? String, hash.characters.count > 0 {
                    
                    if let token = TokenParser.token(forKey: self.authTokenKey, inHash: hash) {
                        
                        self.delegate?.webViewAuthenticator(self, didReceiveToken: token, inWebView: webView)
                        
                    } else {
                        
                        self.delegate?.webViewAuthenticator(self, authDidFailWithError: WebViewAuthenticatorError.parseError(tokenKey: self.authTokenKey), inWebView: webView)
                    }
                    
                } else if let error = error {
                    
                    self.delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
                }
            }
        }
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
    }
}
