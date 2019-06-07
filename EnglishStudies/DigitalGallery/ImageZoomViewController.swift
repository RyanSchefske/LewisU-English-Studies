//
//  ImageZoomViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class ImageZoomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.title = "Digital Gallery"
        
        setupViews()
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "pin")
        return image
    }()
    
    func setupViews() {
        let height = view.frame.height - (navigationController?.navigationBar.frame.height)!
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        view.addSubview(imageView)
    }
}
