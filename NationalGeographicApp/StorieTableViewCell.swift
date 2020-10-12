//
//  StorieTableViewCell.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 12.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StorieTableViewCell: UITableViewCell {
    @IBOutlet var storieImageView: UIImageView!
    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var subtitleTextLabel: UILabel! {
        didSet {
            storieImageView.contentMode = .scaleAspectFit
            storieImageView.clipsToBounds = true
            subtitleTextLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }
    }
    
}
