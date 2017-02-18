//
//  ViewController.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 15.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import UIKit
import WebKit

/// главный контроллер, который загружает форму
/// и получает токен
open class ViewController: UIViewController {
    
    // MARK: properties
    open var authenticator = WebViewAuthenticator(authTokenKey: "authToken")
    
    // MARK: overrides
    override open func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "WebAuthForm"
        view.backgroundColor = .white
        
        let webView = WKWebView(frame: view.bounds, configuration: WKWebViewConfiguration())
        webView.navigationDelegate = authenticator
        webView.scrollView.isScrollEnabled = false
        
        authenticator.delegate = self
        
        addSubview(webView)
        
        let url = Bundle.main.url(forResource: "test_SPA", withExtension: "HTML")!
        
        webView.load(URLRequest(url: url))
    }
}

// MARK: `WebViewAuthenticatorProtocol` conformance
extension ViewController: WebViewAuthenticatorProtocol {
    
    public func webViewAuthenticator(_ webViewAuthenticator: WebViewAuthenticator, didReceiveToken token: String, inWebView webView: WKWebView) {
        
        print(token)
        
        if (token != "null") {
            
            // передаем токен для сохранения другому классу
            // после окончания аутентификации можем переназначить делагат у WKWebView
        }
    }
    
    public func webViewAuthenticator(_ webViewAuthenticator: WebViewAuthenticator, authDidFailWithError error: Error, inWebView webView: WKWebView) {
        
        print(error)
    }
}
