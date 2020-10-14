//
//  StoriesTableViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    private let latestStoriesUrl = "https://www.nationalgeographic.com/latest-stories/_jcr_content/content/hubfeed.promo-hub-feed-all-stories.json?offset=0&max=18"
    var stories: [Storie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        NetworkManager.shared.fetchData(from: latestStoriesUrl) { stories in
            DispatchQueue.main.async {
                self.stories = stories
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storieCell", for: indexPath) as! StorieTableViewCell
        
        let storie = stories[indexPath.row]
        let sponsor = storie.sponsorContent

        if sponsor {
            cell.titleTextLabel.text = storie.components?.first?.title?.text ?? "📰"
            cell.subtitleTextLabel.text = storie.components?[1].dek?.text ?? ""
        } else {
            cell.titleTextLabel.text = storie.components?.last?.kicker?.vertical?.name ?? ""
            cell.subtitleTextLabel.text = storie.components?.first?.title?.text ?? "📰"
        }
        
        cell.getStorieImage(with: storie)

        return cell
    }
    
}
