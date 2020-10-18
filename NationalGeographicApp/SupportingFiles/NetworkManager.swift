//
//  NetworkManager.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 14.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData(from latestStoriesUrl: String, with complition: @escaping ([Storie]) -> Void) {
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
    
}
