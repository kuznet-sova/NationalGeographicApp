//
//  FullStoryViewController.swift
//  NationalGeographicApp
//
//  Created by Ирина Кузнецова on 15.10.2020.
//  Copyright © 2020 Irina Kuznetsova. All rights reserved.
//

import UIKit
import WebKit

class FullStoryViewController: UIViewController {
    @IBOutlet var fullStoryWebView: WKWebView!
    
    var storyUrl: String!
    var storyCategory: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullStoryWebView.backgroundColor = .none
        fullStoryWebView.contentMode = WKWebView.ContentMode.scaleAspectFill
        navigationItem.title = storyCategory
        
        getFullStory()
    }
    
    func getFullStory() {
        guard let url = URL(string: storyUrl)
            else { return }
        fullStoryWebView.load(URLRequest(url: url))
    }

}
