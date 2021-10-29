//
//  WebViewAuthenticatorProtocol.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 20.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import WebKit

/// протокол аутентификации
public protocol WebViewAuthenticatorProtocol: AnyObject {
    
    /// вызывается у делегата, когда из веб-форма загрузилась
    func webViewAuthenticator(_ webViewAuthenticator: WebViewAuthenticator,
                              didLoadWebView webView: WKWebView)
    
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
