//
//  WebViewInteractor.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 16.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit
import WebKit

open class WebViewAuthenticator: NSObject {
    open var authTokenKey: String = ""
    open weak var delegate: WebViewAuthenticatorProtocol?
    
    // MARK: convenience initializer
    convenience public init(authTokenKey: String) {
        self.init()
        
        self.authTokenKey = authTokenKey
    }
    
    open func setInstallationId(_ setInstallationId: String, inWebView webView: WKWebView) {
        let method = "setInstallationId('\(setInstallationId)')"
        
        webView.evaluateJavaScript(method) { (response: Any?, error: Error?) in
            if let error = error {
                self.delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
            }
        }
    }
}

// MARK: `WKNavigationDelegate` conformance
extension WebViewAuthenticator: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.delegate?.webViewAuthenticator(self, didLoadWebView: webView)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        decisionHandler(.allow)
        
        if (navigationAction.navigationType == .other) {
            webView.evaluateJavaScript("window.location.hash") { (response: Any?, error: Error?) in
                if let hash = response as? String, hash.isEmpty == false {
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
        self.delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.delegate?.webViewAuthenticator(self, authDidFailWithError: error, inWebView: webView)
    }
}
