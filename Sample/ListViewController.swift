//
//  ListViewController.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import TwemojiKit
import UIKit

struct TwemojiIcons: Decodable {
    let icons: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        icons = try container.decode([String].self, forKey: .icons)
    }

    enum codingKeys: String, CodingKey {
        case icons
    }
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    private var contents = [String]()
    private let twemoji = Twemoji()

    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
    }

    private func prepare() {
        do {
            let decoder = JSONDecoder()
            guard let url = Bundle.main.url(forResource: "twemoji4", withExtension: ".json") else { return }
            let data = try String(contentsOf: url).data(using: .utf8)
            let json = try decoder.decode(TwemojiIcons.self, from: data!)
            contents = json.icons
        } catch let e {
            fatalError(e.localizedDescription)
        }
        tableView.register(UINib(nibName: "EmojiTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func tappedClose(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 84
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let c = cell as? EmojiTableViewCell, let imageUrl = twemoji.parse(contents[indexPath.row]).first?.imageURL {
            c.configure(base: contents[indexPath.row], url: imageUrl)
        }
        return cell
    }
}
