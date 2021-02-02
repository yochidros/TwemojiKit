//
//  TwemojiImage.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation

private let TwemojiCoreVersion = "12.1.6"
private let TwemojiBaseURL = "https://twemoji.maxcdn.com/v/"
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
        return URL(string: "\(baseURLString)\(TwemojiCoreVersion)/\(size.rawValue)/\(code)\(ext)")
    }
}
