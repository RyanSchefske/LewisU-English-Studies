//
//  SettingCell.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/31/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            if setting?.name != "English Studies @ LewisU" {
                backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
                nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
                iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            }
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "menu")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
