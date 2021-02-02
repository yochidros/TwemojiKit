//
//  EmojiTableViewCell.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import TwemojiKit
import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet var emojiLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        emojiLabel.text = nil
    }

    func configure(base: String, url: URL) {
        emojiLabel.text = base
        iconImageView.loadTwemoji(twemojiUrl: url)
    }
}
