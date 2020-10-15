//
//  FullStorieViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 15.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit
import WebKit

class FullStorieViewController: UIViewController {
    @IBOutlet var fullStorieWebView: WKWebView!
    
    var storieUrl: String!
    var storieCategory: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullStorieWebView.backgroundColor = .white
        navigationItem.title = storieCategory
        
        getFullStorie()
    }
    
    func getFullStorie() {
        guard let url = URL(string: storieUrl)
            else { return }
        fullStorieWebView.load(URLRequest(url: url))
    }

}
