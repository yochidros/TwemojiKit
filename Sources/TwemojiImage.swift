//
//  TwemojiImage.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation

private let TwemojiCoreVersion = "15.1.0"
private let TwemojiBaseURL = "https://cdn.jsdelivr.net/gh/jdecked/twemoji@"
private let TwemojiFormatPng = ".png"

public struct TwemojiImage {
    public let base: String
    public let size: TwemojiSize
    public let code: String
    public let ext: String = TwemojiFormatPng

    private var baseURLString: String {
        return "\(TwemojiBaseURL)"
    }

    public var imageURL: URL? {
        return URL(string: "\(baseURLString)\(TwemojiCoreVersion)/assets/\(size.rawValue)/\(code)\(ext)")
    }
}
