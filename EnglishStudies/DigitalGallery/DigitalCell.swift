//
//  DigitalCell.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class DigitalCell: BaseCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func setupViews() {
        addSubview(cellImageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cellImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
