//
//  SettingsCell.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "cellId")
        setupView()
    }
    
    func setupView() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
