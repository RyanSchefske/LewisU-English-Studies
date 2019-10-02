//
//  ProfessorCell.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/4/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class ProfessorCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
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
