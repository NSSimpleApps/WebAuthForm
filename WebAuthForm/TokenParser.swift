//
//  TokenParser.swift
//  WebAuthForm
//
//  Created by NSSimpleApps on 17.02.17.
//  Copyright © 2017 NSSimpleApps. All rights reserved.
//

import Foundation

/// класс, который парсит hash вида "#key1=value1&key2=value2&key3=value3"
/// и извлекает значение, которое соответствуют ключу `key`
open class TokenParser {
    // MARK: methods
    open class func token(forKey key: String, inHash hash: String) -> String? {
        let hashValue: String
        if hash.first == "#" {
            hashValue = String(hash.dropFirst())
        } else {
            hashValue = hash
        }
        if let components = URLComponents(string: "?" + hashValue), let queryItems = components.queryItems {
            if let queryItem = queryItems.first(where: { queryItem in
                queryItem.name == key
            }) {
                return queryItem.value
            }
        }
        return nil
    }
}
