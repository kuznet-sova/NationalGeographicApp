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

    var photoUri: String?
    var photoCaption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getDefaultImage(imageName: "NatGeoLogo.png") {
            defaultImage in
            self.view.insertSubview(defaultImage, at: 0)
        }
        
        NetworkManager.shared.photoData() {
            photoInfo in
            DispatchQueue.main.async {
                self.photoUri = photoInfo.items.first?.image?.uri
                self.photoCaption = photoInfo.items.first?.image?.caption
                self.photoOfTheDayLabel.text = "\(self.photoCaption ?? "Photo of the day:")"
                
                NetworkManager.shared.getPhoto(with: self.photoUri) {
                    photo in
                    DispatchQueue.main.async {
                        self.photoOfTheDayImageView.image = photo
                        self.photoOfTheDayImageView.contentMode = UIView.ContentMode.scaleAspectFill
                    }
                }
            }
        }
        
    }

}
