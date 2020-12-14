//
//  ViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 08.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var photoOfTheDayImageView: UIImageView!
    @IBOutlet var photoOfTheDayLabel: UILabel!

    var spinnerView: UIActivityIndicatorView?
    var photoUri: String?
    var photoCaption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = LoaderAnimation.shared.showSpinner(in: view)
        
        NetworkManager.shared.getDefaultImage(imageName: "NatGeoLogo.png") {
            defaultImage in
            self.view.insertSubview(defaultImage, at: 0)
            self.spinnerView?.startAnimating()
        }
        
        NetworkManager.shared.photoData() {
            photoInfo in
            DispatchQueue.main.async {
                self.photoUri = photoInfo.items.first?.image?.uri
                self.photoCaption = photoInfo.items.first?.image?.caption
                self.photoOfTheDayLabel.text = "\(self.photoCaption ?? "Photo of the day:")"
                self.getPhotoForData()
            }
        }
        
    }
    
    private func getPhotoForData() {
        NetworkManager.shared.getPhoto(with: self.photoUri) {
            photo in
            DispatchQueue.main.async {
                self.spinnerView?.stopAnimating()
                self.photoOfTheDayImageView.image = photo
                self.photoOfTheDayImageView.contentMode = UIView.ContentMode.scaleAspectFill
            }
        }
    }

}
