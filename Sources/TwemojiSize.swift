//
//  TwemojiSize.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation

public enum TwemojiSize {
    case x72 //= "72x72"
    case custom(String)
    
    public static let `default` = TwemojiSize.x72
    
    public var path: String {
        return switch self {
        case .x72:
            "72x72"
        case let .custom(path):
            path
        }
    }

    public var size: Int {
        switch self {
        case .x72:
            return 72
        case let .custom(size):
            return Int(size) ?? 72
        }
    }
}
