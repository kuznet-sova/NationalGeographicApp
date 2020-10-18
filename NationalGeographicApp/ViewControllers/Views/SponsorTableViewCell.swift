//
//  SponsorTableViewCell.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 17.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class SponsorTableViewCell: UITableViewCell {
    
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var subtitleTextLabel: UILabel!
    
    func getStorieImage(with uri: String?, sponsorContent: Bool) {
        let imageUrl = uri
        
        DispatchQueue.global().async {
            guard let stringUrl = imageUrl,
                let imageUrl = URL(string: stringUrl),
                let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.backgroundColor = UIColor(patternImage: UIImage(data: imageData)!)
            }
        }
    }

}
