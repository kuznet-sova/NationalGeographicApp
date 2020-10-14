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
    
    private init() {}
    
    func fetchData(from latestStoriesUrl: String, with complition: @escaping ([Storie]) -> Void) {
        guard let url = URL(string: latestStoriesUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()

            do {
                let stories = try decoder.decode([Storie].self, from: data)
                complition(stories)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
