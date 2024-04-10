//
//  UIImage+Extension.swift
//  TwemojiKit
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import UIKit

public extension UIImage {
    convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }

    internal func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio

        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)

        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resizedImage
    }

    convenience init?(named: String) {
        self.init(named: named, in: Bundle.twemojiResouces, compatibleWith: nil)
    }
}

extension UIImageView {
    public func loadTwemoji(twemojiUrl: URL?, completion: ((Result<UIImage, any Error>) -> Void)? = nil) {
        guard let url = twemojiUrl else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                completion?(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
                completion?(.success(image))
            }
        }.resume()
    }
}

class ImageBundle {}

public extension Bundle {
    static var twemojiResouces: Bundle {
        return Bundle(for: type(of: ImageBundle()))
    }
}
