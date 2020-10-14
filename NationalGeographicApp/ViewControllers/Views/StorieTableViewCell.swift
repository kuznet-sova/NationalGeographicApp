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

    
    func getStorieImage(with storie: Storie?) {
        let imageUrl = storie?.leadMedia?.image?.uri
        
        DispatchQueue.global().async {
            guard let stringUrl = imageUrl else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
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
        activityIndicator.startAnimating()
        activityIndicator.center = storieImageView.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    override func prepareForReuse() {
        storieImageView.image = nil
        self.spinnerView?.startAnimating()
    }
    
}
