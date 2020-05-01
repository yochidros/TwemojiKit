//
//  ListViewController.swift
//  Sample
//
//  Created by miyazawa yoshiki on 2020/04/24.
//  Copyright © 2020 yochidros. All rights reserved.
//

import UIKit
import TwemojiKit

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
    @IBOutlet weak var tableView: UITableView!

    private var contents = [String]()

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

    @IBAction func tappedClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let c = cell as? EmojiTableViewCell {
            let a = Twemoji.shared.parse(contents[indexPath.row]).first?.imageURL
            c.configure(base: contents[indexPath.row], url: a)
        }
        return cell
    }
}
