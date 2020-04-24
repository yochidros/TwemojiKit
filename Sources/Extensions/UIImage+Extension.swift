//
//  UIImage+Extension.swift
//  TwemojiKit
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import UIKit

extension UIImage {
    public convenience init(url: URL) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
    func resize(size _size: CGSize) -> UIImage? {
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
}
