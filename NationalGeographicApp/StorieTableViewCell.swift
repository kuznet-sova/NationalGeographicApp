//
//  StorieTableViewCell.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 12.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StorieTableViewCell: UITableViewCell {

    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var subtitleTextLabel: UILabel!
    @IBOutlet var storieImageView: UIImageView! {
        didSet {
            storieImageView.contentMode = .scaleAspectFit
            storieImageView.clipsToBounds = true
//            storieImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }
    }

    
    func getStorieImage(with storie: Storie?) {
        let imageUrl = storie?.leadMedia?.image?.uri
        
        DispatchQueue.global().async {
            guard let stringUrl = imageUrl else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.storieImageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
