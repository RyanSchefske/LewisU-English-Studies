//
//  HomeCell.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/31/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupViews()
    }
    
    var homeItem: HomeItems? {
        didSet {
            titleLabel.text = homeItem?.cellTitle
            subTitleLabel.text = homeItem?.cellSubTitle
            
            if let imageName = homeItem?.imageName {
                cellImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        //imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        if UIDevice.current.userInterfaceIdiom == .pad {
            label.font = label.font.withSize(48)
        } else {
            label.font = label.font.withSize(24)
        }
        
        label.layer.shadowColor = UIColor.lightGray.cgColor
        label.layer.shadowRadius = 1
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        if UIDevice.current.userInterfaceIdiom == .pad {
            label.font = label.font.withSize(26)
        } else {
            label.font = label.font.withSize(13)
        }
        label.numberOfLines = 0
        
        return label
    }()
    
    func setupViews() {
        addSubview(cellImageView)
        cellImageView.addSubview(titleLabel)
        cellImageView.addSubview(subTitleLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: cellImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: cellImageView)
        
        //subTitleLabel Constraints
        //Left Constriant
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: cellImageView, attribute: .left, multiplier: 1, constant: 8))
        
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .right, relatedBy: .equal, toItem: cellImageView, attribute: .right, multiplier: 1, constant: 4))
        
        //Bottom Constraint
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .bottom, relatedBy: .equal, toItem: cellImageView, attribute: .bottom, multiplier: 1, constant: -8))
        
        //titleLabel Constraints
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: subTitleLabel, attribute: .left, multiplier: 1, constant: 0))
        
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: subTitleLabel, attribute: .right, multiplier: 1, constant: 4))
        
        //Bottom Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: subTitleLabel, attribute: .top, multiplier: 1, constant: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
