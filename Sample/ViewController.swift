//
//  ViewController.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import UIKit
import TwemojiKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emojiLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if Twemoji.isAvailable {
            let para = NSMutableParagraphStyle()
            para.lineSpacing = 4
            let attrs = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
                NSAttributedString.Key.paragraphStyle: para,
                NSAttributedString.Key.kern: 4
                ] as [NSAttributedString.Key : Any]
            emojiLabel.attributedText = Twemoji.shared.parseAttributeString("テスt💪あaテスト🐶こんにちは🐶", size: 13, attributes: attrs)
            imageView.image = Twemoji.shared.convertImage(twemoji: Twemoji.shared.parse("🐶").first!)
        }
    }


}

