//
//  ViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 08.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getDefaultImage(imageName: "NatGeoLogo.png") {
            defaultImage in
            self.view.insertSubview(defaultImage, at: 0)
        }
    }
    
}
