//
//  TwemojiSize.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation

public enum TwemojiSize: String {
    case x72 = "72x72"

    public static let `default` = TwemojiSize.x72

    public var size: Int {
        switch self {
        case .x72:
            return 72
        }
    }

}
