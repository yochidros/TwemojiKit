//
//  Twemoji.swift
//  TwemojiKit
//
//  Created by yochidros on 2020/04/23.
//  Copyright © 2020 yochidros. All rights reserved.
//

import Foundation
import JavaScriptCore
import UIKit

private let TwemojiCoreName = "twemoji.min"
private let TwemojiCoreExt = ".js"
private let bundleIdentifier = "com.yochidros.TwemojiKit"

public class Twemoji {
    private let context = JSContext(virtualMachine: JSVirtualMachine())
    private static let privaetShared: Twemoji = Twemoji()
    private var isAvailable: Bool = false
    private typealias ConvertedType = (base: String, code: String)
    
    public class var isAvailable: Bool {
        return privaetShared.isAvailable
    }

    public class var shared: Twemoji {
        return privaetShared
    }

    init() {
        prepare()
    }

    private func prepare() {
        if let jsFilePath = Bundle.init(identifier: bundleIdentifier)?.path(forResource: TwemojiCoreName, ofType: TwemojiCoreExt) {
            let expandedPath = NSString(string: jsFilePath).expandingTildeInPath
            guard let coreContent = try? String(contentsOfFile: expandedPath) else { return }
            context?.evaluateScript(coreContent)
            context?.evaluateScript("var twemoji = require('twemoji');")
            isAvailable = true
            return
        }
        isAvailable = false
    }

    public func parse(_ str: String, size: TwemojiSize = .default) -> [TwemojiImage] {
        guard str.containsEmoji, test(str: str) else { return [] }
        var converted = parseWithJS(str: str, size: size)
        guard !converted.isEmpty else {
            converted = convertToCode(str: str)
            return converted.map({ TwemojiImage.init(base: $0.base, size: size, code: $0.code)})
        }
        return converted.map({ TwemojiImage.init(base: $0.base, size: size, code: $0.code)})
    }

    public func parseAttributeString(_ str: String, size: Int = TwemojiSize.default.size, attributes attrs: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: str, attributes: attrs)
        let emojiImages = parse(str, size: TwemojiSize.create(size: size))
        var startIndex = attrString.string.startIndex
        emojiImages.forEach { (image) in
            if let range = attrString.string[startIndex...].range(of: image.base), let url = image.imageURL {
                let nsRange = NSRange(range, in: attrString.string)
                startIndex = attrString.string.index(startIndex, offsetBy: 0)
                let attachment = NSTextAttachment()
                attachment.image = UIImage(url: url).resize(size: CGSize(width: size, height: size))
                attachment.bounds = CGRect(x: 0, y: -2, width: CGFloat(size), height: CGFloat(size))
                attrString.replaceCharacters(in: nsRange, with: NSAttributedString(attachment: attachment))
            }
        }
        return NSAttributedString(attributedString: attrString)
    }
    public func convertImage(twemoji: TwemojiImage) -> UIImage {
        return UIImage(url: twemoji.imageURL!)
    }

}

// MARK: Private Methods
extension Twemoji {

    private func convertToCode(str: String) -> [ConvertedType] {
        // swift scalars contains \\u{000xxxx}
        let emojis = str.emojis.map({ String($0) })
        guard !emojis.isEmpty else { return [] }
        var result = [ConvertedType]()
        emojis.enumerated().forEach({ (index, value) in
            let code = value.unicodeScalars
                .map({ $0.escaped(asASCII: true)})
                .joined(separator: "-")
                .replacingOccurrences(of: "{", with: "")
                .replacingOccurrences(of: "}", with: "")
                .replacingOccurrences(of: "000", with: "")
                .lowercased()
            if !code.isEmpty {
                let converted: ConvertedType = (base: value, code: code)
                result.append(converted)
            }
        })
        return result
    }

    private func parseWithJS(str: String, size: TwemojiSize) -> [ConvertedType] {
        var result = [ConvertedType]()
        str.emojis.map { String($0)}.forEach { (emoji) in
            context?.evaluateScript("""
                twemoji.size = 16
                var iconCode = ""
                var twemojiCode = twemoji.parse('\(emoji)', {
                    callback: function(iconId, options) {
                        iconCode = iconId;
                        return '';
                    }
                });
                """)
            if let code = context?["iconCode"]?.toString(), !code.isEmpty {
                let converted: ConvertedType = (base: emoji, code: code)
                result.append(converted)
            }

        }
        return result
    }

    private func test(str: String) -> Bool {
        context?.evaluateScript("var result = twemoji.test('\(str)');")
        guard let result = context?.objectForKeyedSubscript("result")?.toBool() else { return false }
        return result
    }

}
