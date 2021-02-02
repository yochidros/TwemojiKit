//
//  JSContext+Extension.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import JavaScriptCore

extension JSContext {
    subscript(_ get: String) -> JSValue? {
        get {
            return objectForKeyedSubscript(get)
        }
        set {
            fatalError("get: cannot be used to set")
        }
    }

    subscript(_ set: String) -> Any! {
        set {
            setObject(newValue, forKeyedSubscript: set as NSString)
        }

        get {
            fatalError("set: cannot be used to get")
        }
    }
}
