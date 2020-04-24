//
//  TwemojiSize.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation

public enum TwemojiSize: String {
    case x16 = "16x16"
    case x36 = "36x36"
    case x72 = "72x72"

    public static let `default` = TwemojiSize.x72

    public var size: Int {
        switch self {
        case .x16:
            return 16
        case .x36:
            return 36
        case .x72:
            return 72
        }
    }

    public static func create(size: Int) -> TwemojiSize {
        switch size {
        case 0..<TwemojiSize.x16.size:
            return TwemojiSize.x16
        case TwemojiSize.x16.size..<TwemojiSize.x36.size:
            return TwemojiSize.x36
        case TwemojiSize.x36.size..<TwemojiSize.x72.size:
            return TwemojiSize.x72
        default:
            return .default
        }
    }
}
