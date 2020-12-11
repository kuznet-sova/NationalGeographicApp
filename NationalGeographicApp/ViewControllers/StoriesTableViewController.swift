//
//  StoriesTableViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 09.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

protocol ChoosenCategoryDelegate: AnyObject {
    func getChoosenCategory(_ choosenCategory: String)
}

class StoriesTableViewController: UITableViewController {
    @IBOutlet var storiesTableView: UITableView!
    
    private var offsetValue = 0
    private var maxValue = 18
    var stories: [Story] = []
    var category = "All"
    
    let refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        storiesTableView.refreshControl = refresh

        NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue, category: category) { stories in
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
        let story = stories[indexPath.row]
        let sponsor = story.sponsorContent

        if sponsor {
            let cell = tableView.dequeueReusableCell(withIdentifier: "sponsorCell", for: indexPath) as! SponsorTableViewCell
            NetworkManager.shared.getStoryImage(with: checkImageUrl(story: story), sponsorContent: story.sponsorContent) {
                image in
                DispatchQueue.main.async {
                    cell.backgroundColor = UIColor(patternImage: image)
                }
            }
            cell.titleTextLabel.text = story.components?.first?.title?.text ?? "📰"
            cell.subtitleTextLabel.text = story.components?[1].dek?.text ?? ""
            cell.titleTextLabel.textColor = .white
            cell.subtitleTextLabel.textColor = .white
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! StoryTableViewCell
            cell.spinnerView?.startAnimating()
            
            NetworkManager.shared.getStoryImage(with: checkImageUrl(story: story), sponsorContent: story.sponsorContent) {
                image in
                cell.spinnerView?.stopAnimating()
                cell.storyImageView.image = image
                cell.storyImageView.contentMode = UIView.ContentMode.scaleAspectFill
            }
            cell.titleTextLabel.text = story.components?.last?.kicker?.vertical?.name ?? ""
            cell.subtitleTextLabel.text = story.components?.first?.title?.text ?? "📰"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == stories.count-1 {
            offsetValue += maxValue
            maxValue = 8
            
            NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue, category: category) { stories in
                DispatchQueue.main.async {
                    self.stories.append(contentsOf: stories)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filter" {
            guard let filteringPickerViewController = segue.destination as? FilteringPickerViewController
            else { return }
            filteringPickerViewController.choosenCategory = category
            filteringPickerViewController.delegateCategory = self
        } else {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let story = stories[indexPath.row]
            let sponsor = story.sponsorContent
            let fullStoryViewController = segue.destination as! FullStoryViewController
            
            fullStoryViewController.storyUrl = story.uri
            if sponsor {
                fullStoryViewController.storyCategory = story.sponsorContentLabel
            } else {
                fullStoryViewController.storyCategory = story.components?.last?.kicker?.vertical?.name
            }
        }
    }
    
    private func checkImageUrl(story: Story) -> String? {
        var imageUrl: String?
        
        if story.leadMedia?.image?.uri != nil {
            imageUrl = story.leadMedia?.image?.uri
        } else if story.leadMedia?.video?.image?.uri != nil {
            imageUrl = story.leadMedia?.video?.image?.uri
        } else if story.leadMedia?.immersiveLead?.immersiveLeadMedia?.image?.uri != nil {
            imageUrl = story.leadMedia?.immersiveLead?.immersiveLeadMedia?.image?.uri
        } else if story.leadMedia?.immersiveLead?.immersiveLeadMedia?.video?.image?.uri != nil {
            imageUrl = story.leadMedia?.immersiveLead?.immersiveLeadMedia?.video?.image?.uri
        } else if story.promoImage?.image?.uri != nil {
            imageUrl = story.promoImage?.image?.uri
        }
        
        return imageUrl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        offsetValue = 0
        maxValue = 18
        
        NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue, category: category) { stories in
            DispatchQueue.main.async {
                self.stories = stories
                self.tableView.reloadData()
            }
        }
        sender.endRefreshing()
    }
    
}

extension StoriesTableViewController: ChoosenCategoryDelegate {
    func getChoosenCategory(_ choosenCategory: String) {
        if choosenCategory != category {
            offsetValue = 0
            maxValue = 18
            category = choosenCategory
            
            NetworkManager.shared.fetchData(offsetValue: offsetValue, maxValue: maxValue, category: category) { stories in
                DispatchQueue.main.async {
                    self.stories = stories
                    self.tableView.reloadData()
                }
            }
        }
    }
}
