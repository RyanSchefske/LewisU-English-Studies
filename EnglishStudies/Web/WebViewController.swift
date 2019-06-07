//
//  WebViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/18/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    var passedUrl = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: Selector(("refreshClicked")))
        
        if passedUrl != "" {
            if let url = URL(string: passedUrl) {
                webView.load(URLRequest(url: url))
            }
        }
    }
    
    @objc func refreshClicked() {
        webView.reload()
    }

}
