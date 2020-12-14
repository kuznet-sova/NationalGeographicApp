//
//  StoryTableViewCell.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 12.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var subtitleTextLabel: UILabel!
    @IBOutlet var storyImageView: UIImageView!
    
    var spinnerView: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinnerView = LoaderAnimation.shared.showSpinner(in: storyImageView)
    }
    
    override func prepareForReuse() {
        storyImageView.image = nil
        spinnerView?.stopAnimating()
    }
    
}
