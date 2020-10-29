//
//  StoriesTableViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StoriesTableViewController: UITableViewController {
    @IBOutlet var storiesTableView: UITableView!
    
    private var offsetValue = 0
    private var maxValue = 18
    var stories: [Storie] = []
    
    let refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        storiesTableView.refreshControl = refresh

        NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue) { stories in
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
        let storie = stories[indexPath.row]
        let sponsor = storie.sponsorContent
        var imageUrl: String?
        
        if storie.leadMedia?.image?.uri != nil {
            imageUrl = storie.leadMedia?.image?.uri
        } else if storie.leadMedia?.video?.image?.uri != nil {
            imageUrl = storie.leadMedia?.video?.image?.uri
        } else if storie.leadMedia?.immersiveLead?.immersiveLeadMedia?.image?.uri != nil {
            imageUrl = storie.leadMedia?.immersiveLead?.immersiveLeadMedia?.image?.uri
        }

        if sponsor {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sponsorCell", for: indexPath) as! SponsorTableViewCell
            NetworkManager.shared.getStorieImage(with: imageUrl, sponsorContent: storie.sponsorContent) {
                image in
                DispatchQueue.main.async {
                    cell.backgroundColor = UIColor(patternImage: image)
                }
            }
            cell.titleTextLabel.text = storie.components?.first?.title?.text ?? "📰"
            cell.subtitleTextLabel.text = storie.components?[1].dek?.text ?? ""
            
            if imageUrl != nil {
                cell.titleTextLabel.textColor = .white
                cell.subtitleTextLabel.textColor = .white
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storieCell", for: indexPath) as! StorieTableViewCell
            cell.spinnerView?.startAnimating()
            
            NetworkManager.shared.getStorieImage(with: imageUrl, sponsorContent: storie.sponsorContent) {
                image in
                DispatchQueue.main.async {
                    cell.spinnerView?.stopAnimating()
                    cell.storieImageView.image = image
                    cell.storieImageView.contentMode = UIView.ContentMode.scaleAspectFill
                }
            }
            cell.titleTextLabel.text = storie.components?.last?.kicker?.vertical?.name ?? ""
            cell.subtitleTextLabel.text = storie.components?.first?.title?.text ?? "📰"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == stories.count-1 {
            offsetValue += maxValue
            maxValue = 8
            
            NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue) { stories in
                DispatchQueue.main.async {
                    self.stories.append(contentsOf: stories)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let storie = stories[indexPath.row]
        let sponsor = storie.sponsorContent
        let fullStorieViewController = segue.destination as! FullStorieViewController
        
        fullStorieViewController.storieUrl = storie.uri
        if sponsor {
            fullStorieViewController.storieCategory = storie.sponsorContentLabel
        } else {
            fullStorieViewController.storieCategory = storie.components?.last?.kicker?.vertical?.name
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        offsetValue = 0
        maxValue = 18
        
        NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue) { stories in
            DispatchQueue.main.async {
                self.stories = stories
                self.tableView.reloadData()
            }
        }
        sender.endRefreshing()
    }
    
}
