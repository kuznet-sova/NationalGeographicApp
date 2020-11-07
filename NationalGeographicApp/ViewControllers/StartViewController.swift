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
    
    var photoUri: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let widthImageView = photoOfTheDayImageView.frame.width
//        photoOfTheDayImageView.frame = CGRect(x: 0,
//                                              y: 0,
//                                              width: widthImageView,
//                                              height: widthImageView / 2)

        photoOfTheDayImageView.backgroundColor = .green
        
        NetworkManager.shared.getDefaultImage(imageName: "NatGeoLogo.png") {
            defaultImage in
            self.view.insertSubview(defaultImage, at: 0)
        }
        
        NetworkManager.shared.photoData() {
            photoInfo in
            DispatchQueue.main.async {
                self.photoUri = photoInfo.items.first?.image?.uri
                
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
