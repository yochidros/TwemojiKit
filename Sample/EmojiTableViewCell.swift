//
//  EmojiTableViewCell.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import UIKit
import TwemojiKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(base: String, url: URL?) {
        emojiLabel.text = base
        guard let url = url else { return }
            URLSession.shared.dataTask(with: url) { (d, r, e) in
                DispatchQueue.main.async {
                    guard let data = d else { return }
                    self.iconImageView.image = UIImage(data: data)
                }
        }.resume()
    }
}
