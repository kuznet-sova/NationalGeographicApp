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
    
    func fetchData(offsetValue: Int, maxValue: Int, category: String, with complition: @escaping ([Story]) -> Void) {
        let latestStoriesUrl = "https://www.nationalgeographic.com/latest-stories/_jcr_content/content/hubfeed.promo-hub-feed-all-stories.json?offset=\(offsetValue)&max=\(maxValue)"
        
        guard let url = URL(string: latestStoriesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let storiesList = try decoder.decode([Story].self, from: data)
                
                if category == "Partner Content" {
                    complition(self.getData(storiesList: storiesList, category: nil))
                } else {
                    complition(self.getData(storiesList: storiesList, category: category))
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func photoData(with complition: @escaping (PhotoOfTheDay) -> Void) {
        let photoUrl = "https://www.nationalgeographic.com/photography/photo-of-the-day/_jcr_content/.syndication-gallery.json"
        
        guard let url = URL(string: photoUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let photoInfo = try decoder.decode(PhotoOfTheDay.self, from: data)
                
                complition(photoInfo)
                
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getStoryImage(with uri: String?, sponsorContent: Bool, with complition: @escaping (UIImage) -> Void) {
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
            
            DispatchQueue.main.async {
                self.cashedImages.updateValue(image, forKey: stringUrl)
                complition(image)
            }
        }
    }
    
    func getDefaultImage(imageName: String, with complition: @escaping (UIImageView) -> Void) {
        let defaultImage = UIImageView(frame: UIScreen.main.bounds)
        defaultImage.image = UIImage(named: imageName)
        defaultImage.contentMode = UIView.ContentMode.scaleAspectFill
        
        complition(defaultImage)
    }
    
    func getPhoto(with uri: String?, with complition: @escaping (UIImage) -> Void) {
        let photoUrl = uri
        guard let stringUrl = photoUrl else { return }

        dispatchQueue.async {
            guard let photoUrl = URL(string: stringUrl),
                let photoData = try? Data(contentsOf: photoUrl),
                let photo = UIImage(data: photoData) else { return }
            
            complition(photo)
        }
    }
    
    private func getData(storiesList: [Story], category: String?) -> [Story] {
        var stories = [Story]()
        
        for index in 0 ..< storiesList.count {
            let stroy = storiesList[index]
            var chosenCategory: String? = "All"
            
            if category != "All" {
                chosenCategory = stroy.components?.last?.kicker?.vertical?.name
            }

            if stroy.buttonLabel.contains("Read")
                && category == chosenCategory
                && (stroy.leadMedia?.image?.uri != nil
                        || stroy.sponsorContent) {
                stories.append( stroy )
            }
        }
        
        return stories
    }
    
}
