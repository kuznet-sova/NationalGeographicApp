//
//  NetworkManager.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 14.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    var cashedImages: [String: UIImage] = [:]
    var dispatchQueue = DispatchQueue.global()
    
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
    
    func getStorieImage(with uri: String?, sponsorContent: Bool, with complition: @escaping (UIImage) -> Void) {
        let imageUrl = uri
        guard let stringUrl = imageUrl else { return }

        if let cashedImage = self.cashedImages[stringUrl] {
            complition(cashedImage)
            return
        }
        
        dispatchQueue.async {
            guard let imageUrl = URL(string: stringUrl),
                let imageData = try? Data(contentsOf: imageUrl),
                let image = UIImage(data: imageData) else { return }
            
            self.cashedImages.updateValue(image, forKey: stringUrl)
            complition(image)
        }
    }
    
    func getDefaultImage(imageName: String, with complition: @escaping (UIImageView) -> Void) {
        let defaultImage = UIImageView(frame: UIScreen.main.bounds)
        defaultImage.image = UIImage(named: imageName)
        defaultImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        complition(defaultImage)
    }
    
}
