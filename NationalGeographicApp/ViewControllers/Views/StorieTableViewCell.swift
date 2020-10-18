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
    
    private var spinnerView: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinnerView = showSpinner(in: storieImageView)
    }
    
    override func prepareForReuse() {
        storieImageView.image = nil
        self.spinnerView?.stopAnimating()
    }
    
    func getStorieImage(with uri: String?, sponsorContent: Bool) {
        let imageUrl = uri
        
        spinnerView?.startAnimating()
        
        DispatchQueue.global().async {
            guard let stringUrl = imageUrl,
                let imageUrl = URL(string: stringUrl),
                let imageData = try? Data(contentsOf: imageUrl) else {
                    DispatchQueue.main.async {
                        self.spinnerView?.stopAnimating()
                    }
                    return
            }
            DispatchQueue.main.async {
                self.spinnerView?.stopAnimating()
                self.storieImageView.image = UIImage(data: imageData)
                self.storieImageView.contentMode = UIView.ContentMode.scaleAspectFill
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = storieImageView.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
}
