//
//  AboutViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    let versionNumber: String? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        view.backgroundColor = .white
        navigationItem.title = "About"
    }
    
    func setupView() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = label.font.withSize(18)
        label.textColor = .black
        label.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        label.textAlignment = .center
        label.text = "Developed by: Ryan Schefske"
        self.view.addSubview(label)
        
        let lewisLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        lewisLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        lewisLabel.font = label.font.withSize(18)
        lewisLabel.textColor = .red
        lewisLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2.5)
        lewisLabel.textAlignment = .center
        lewisLabel.text = "Property of Lewis University"
        self.view.addSubview(lewisLabel)
        
        let versionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        versionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        versionLabel.textColor = .black
        versionLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3)
        versionLabel.textAlignment = .center
        if let version = versionNumber {
            versionLabel.text = "Version Number: \(version)"
        }
        self.view.addSubview(versionLabel)
    }
}
