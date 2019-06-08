//
//  HeaderView.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/5/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.image = UIImage(named: "DeLasalle")
        return image
    }()
    
    func setupViews() {
        addSubview(cellImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cellImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
