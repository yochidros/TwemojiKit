//
//  ViewController.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import TwemojiKit
import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var emojiLabel: UILabel!
    private let twemoji = Twemoji()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if twemoji.isAvailable {
            let para = NSMutableParagraphStyle()
            para.lineSpacing = 4
            let attrs = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13),
                NSAttributedString.Key.paragraphStyle: para,
                NSAttributedString.Key.kern: 4,
            ] as [NSAttributedString.Key: Any]
            emojiLabel.attributedText = twemoji.parseAttributeString("Hello!!🐱☺️", size: 13, attributes: attrs)

            imageView.loadTwemoji(twemojiUrl: twemoji.parse("🐶").first?.imageURL)
        }
    }

    @IBAction func tappedShowList(_: UIButton) {
        let vc = ListViewController(nibName: "ListViewController", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
}
