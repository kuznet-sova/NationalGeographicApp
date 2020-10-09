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

        tableView.rowHeight = 90
        fetchData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storieCell", for: indexPath)
        
        let storie = stories[indexPath.row]
//        print(storie.leadMedia?.immersiveLead[indexPath.row].title)
        cell.textLabel?.text = storie.id
//        cell.textLabel?.text = storie.leadMedia?.immersiveLead?.title
//        cell.detailTextLabel?.text = storie.leadMedia?.immersiveLead?.description

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
//                    self.filteringStories()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
//    func filteringStories() {
//        var storiesList = [Storie]()
//        var leadMediaList = [LeadMedia]()
//        var immersiveLeadList = [ImmersiveLead]()
//
//        for index in 0 ..< stories.count {
//            if !stories[index].id.isEmpty {
//                storiesList.append(
//                    Storie (
//                        id: stories[index].id,
//                        leadMedia: stories[index].leadMedia
//                    )
//                )
//
//            }
//        }
//        self.stories = storiesList
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
