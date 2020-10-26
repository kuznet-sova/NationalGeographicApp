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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if storieImageView.image == nil {
            showSpinner(in: storieImageView).startAnimating()
        } else {
            showSpinner(in: storieImageView).stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        storieImageView.image = nil
        showSpinner(in: storieImageView).stopAnimating()
    }
    
    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .gray
            activityIndicator.center = storieImageView.center
            activityIndicator.hidesWhenStopped = true

            view.addSubview(activityIndicator)

            return activityIndicator
        }
    
}
