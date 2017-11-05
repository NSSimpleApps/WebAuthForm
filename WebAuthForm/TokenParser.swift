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
    
        let keyLength = key.count
        let scanner = Scanner(string: hash)
    
        if (scanner.scanUpTo(key, into: nil)) {
    
            let delimiterLocation = scanner.scanLocation + keyLength
    
            if (delimiterLocation + 1 < scanner.string.count) {
    
                let index = scanner.string.index(scanner.string.startIndex, offsetBy: delimiterLocation)
    
                if (scanner.string[index] == "=") {

                    var result: NSString?
                    
                    scanner.scanLocation = delimiterLocation + 1
                    scanner.scanUpTo("&", into: &result)
                    
                    return result as String?
                }
            }
        }
        
        return nil
    }
}
