//
//  LoaderAnimation.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 14.12.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit

class LoaderAnimation {
    static let shared = LoaderAnimation()
    
    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true

        view.addSubview(activityIndicator)

        return activityIndicator
    }
    
}
