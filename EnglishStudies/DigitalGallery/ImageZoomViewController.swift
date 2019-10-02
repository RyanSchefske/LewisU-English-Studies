//
//  ImageZoomViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import FirebaseStorage

class ImageZoomViewController: UIViewController {
    
    var selectedPhoto = ""
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.title = "Digital Gallery"
        
        setupViews()
        
        print(selectedPhoto)
        
        let reference = storageRef.child("images/\(selectedPhoto)")
        imageView.sd_setImage(with: reference)
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func setupViews() {
        let height = view.frame.height - (navigationController?.navigationBar.frame.height)!
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        view.addSubview(imageView)
    }
}
