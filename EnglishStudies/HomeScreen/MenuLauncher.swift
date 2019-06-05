//
//  MenuLauncher.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/31/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

//Menu Items
class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class MenuLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    //Menu Cells
    let settings: [Setting] = {
        return [Setting(name: "English Studies @ LewisU", imageName: "home"), Setting(name: "News and Events", imageName: "menu"), Setting(name: "English Studies on Facebook", imageName: "facebook"), Setting(name: "World Languages Program", imageName: "website"), Setting(name: "The English Department", imageName: "menu"), Setting(name: "Writing Center", imageName: "menu"), Setting(name: "OWL - Online Writing Center", imageName: "menu"), Setting(name: "Jet Fuel Review", imageName: "menu"), Setting(name: "The Jet Fuel Blog", imageName: "airplane"), Setting(name: "Windows Fine Arts Magazine", imageName: "menu"), Setting(name: "Romeoville Campus on GPS", imageName: "pin"), Setting(name: "A Digital Gallery", imageName: "menu"), Setting(name: "Chat Room for Students", imageName: "menu"), Setting(name: "Professors", imageName: "menu"), Setting(name: "Settings", imageName: "settings"), Setting(name: "About", imageName: "menu")]
    }()
    
    var homePageController: HomePageViewController?
    
    let cellHeight: CGFloat = 50
    
    @objc func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let width: CGFloat = CGFloat(window.frame.width / 1.5)
            let x = -window.frame.width + width
            
            collectionView.frame = CGRect(x: x, y: 0, width: width, height: window.frame.height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let width: CGFloat = CGFloat(window.frame.width / 1.5)
                let x = -window.frame.width - width
                
                self.collectionView.frame = CGRect(x: x, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "cellId")
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(handleDismiss))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.blackView.addGestureRecognizer(swipeLeft)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let width: CGFloat = CGFloat(window.frame.width / 1.5)
                let x = -window.frame.width - width
                
                self.collectionView.frame = CGRect(x: x, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed) in
            let setting = self.settings[indexPath.item]
            self.homePageController?.showControllerForSetting(setting: setting)
        }
    }
}
