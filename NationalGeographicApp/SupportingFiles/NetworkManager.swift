//
//  NetworkManager.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 14.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class NetworkManager {
//    private var spinnerView: UIActivityIndicatorView?
    
    static let shared = NetworkManager()
    
    func fetchData(offsetValue: Int, maxValue: Int, with complition: @escaping ([Storie]) -> Void) {
        let latestStoriesUrl = "https://www.nationalgeographic.com/latest-stories/_jcr_content/content/hubfeed.promo-hub-feed-all-stories.json?offset=\(offsetValue)&max=\(maxValue)"
        
        guard let url = URL(string: latestStoriesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let storiesList = try decoder.decode([Storie].self, from: data)
                var stories = [Storie]()
                
                for index in 0 ..< storiesList.count {
                    
                    if storiesList[index].buttonLabel.contains("Read")
                        && storiesList[index].leadMedia?.image?.uri != nil
                        || storiesList[index].sponsorContent {
                        stories.append(
                            Storie(id: storiesList[index].id,
                                   uri: storiesList[index].uri,
                                   buttonLabel: storiesList[index].buttonLabel,
                                   sponsorContent: storiesList[index].sponsorContent,
                                   sponsorContentLabel: storiesList[index].sponsorContentLabel,
                                   leadMedia: storiesList[index].leadMedia,
                                   components: storiesList[index].components)
                        )
                    }
                }
                
                complition(stories)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getStorieImage(with uri: String?, sponsorContent: Bool, with complition: @escaping (Data) -> Void) {
        let imageUrl = uri
        
//        spinnerView?.startAnimating()
        
        DispatchQueue.global().async {
            guard let stringUrl = imageUrl,
                let imageUrl = URL(string: stringUrl),
                let imageData = try? Data(contentsOf: imageUrl) else {
//                    DispatchQueue.main.async {
//                        self.spinnerView?.stopAnimating()
//                    }
                    return
            }
//            DispatchQueue.main.async {
//                self.spinnerView?.stopAnimating()
//            }
            complition(imageData)
        }
    }
    
}
