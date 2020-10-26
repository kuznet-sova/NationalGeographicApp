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
     
    override func prepareForReuse() {
        self.backgroundColor = nil
    }

}
