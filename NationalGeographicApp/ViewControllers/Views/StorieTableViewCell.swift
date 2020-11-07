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
    @IBOutlet var storieImageView: UIImageView!
    
    var spinnerView: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinnerView = NetworkManager.shared.showSpinner(in: storieImageView)
    }
    
    override func prepareForReuse() {
        storieImageView.image = nil
        spinnerView?.stopAnimating()
    }
    
}
