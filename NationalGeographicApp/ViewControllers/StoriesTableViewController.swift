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
        fetchData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storieCell", for: indexPath)
        
        let storie = stories[indexPath.row]
        let sponsor = storie.sponsorContent

        if sponsor == true {
            cell.textLabel?.text = storie.components?.first?.title?.text ?? "📰"
            cell.detailTextLabel?.text = storie.components?[1].dek?.text ?? ""
        } else {
            cell.textLabel?.text = storie.components?.last?.kicker?.vertical?.name ?? ""
            cell.detailTextLabel?.text = storie.components?.first?.title?.text ?? "📰"
        }
        
//        cell.imageView?.image = UIImage(systemName: "")

        return cell
    }
    
    func fetchData() {
        guard let url = URL(string: latestStoriesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                self.stories = try decoder.decode([Storie].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }

}
