//
//  WebViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/18/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    var passedUrl = ""
    var navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if navTitle != "" {
            self.title = navTitle
        }
        
        if passedUrl != "" {
            if let url = URL(string: passedUrl) {
                webView.load(URLRequest(url: url))
            }
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: Selector(("refreshClicked")))

    }

}
