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
        return [Setting(name: "English Studies @ LewisU", imageName: "home"), Setting(name: "News and Events", imageName: "document"), Setting(name: "English Studies on Facebook", imageName: "facebook"), Setting(name: "Portfolium", imageName: "menu"), Setting(name: "The English Department", imageName: "emailAt"), Setting(name: "World Languages Program", imageName: "graduationCap"), Setting(name: "Film Studies Program", imageName: "menu"), Setting(name: "Writing Center", imageName: "pencil"), Setting(name: "OWL - Online Writing Center", imageName: "website"), Setting(name: "Resources for Research", imageName: "menu"), Setting(name: "Resources for Writers", imageName: "menu"), Setting(name: "Jet Fuel Review", imageName: "globe"), Setting(name: "The Jet Fuel Blog", imageName: "airplane"), Setting(name: "Windows Fine Arts Magazine", imageName: "magazine"), Setting(name: "Romeoville Campus on GPS", imageName: "pin"), Setting(name: "Digital Gallery", imageName: "gallery"), Setting(name: "Chat Room for Students", imageName: "chat"), Setting(name: "Professors", imageName: "contacts"), Setting(name: "Podcasts", imageName: "headphones"), Setting(name: "Settings", imageName: "settings"), Setting(name: "About", imageName: "info")]
    }()
    
    var homePageController: HomePageViewController?
    
    let cellHeight: CGFloat = 60
    
    @objc func showMenu() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let width: CGFloat = CGFloat(window.frame.width / 1.5)
            let x = -width
            
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
                let x = -width
                
                self.collectionView.frame = CGRect(x: x, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
            }
        }
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
                
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
        
        if indexPath.item == 0 {
            cell.backgroundColor = UIColor.darkGray
            cell.nameLabel.textColor = UIColor.white
            cell.iconImageView.tintColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                let width: CGFloat = CGFloat(window.frame.width / 1.5)
                let x = -width
                
                self.collectionView.frame = CGRect(x: x, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed) in
            if indexPath.item != 0 {
                let setting = self.settings[indexPath.item]
                if indexPath.item == 1 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://luenglishstudies.blogspot.com/2017/11/blog-post.html?m=1")
                } else if indexPath.item == 2 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://www.facebook.com/LUEnglishStudies/")
                } else if indexPath.item == 3 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://portfolium.com/network/lewis-university")
                } else if indexPath.item == 4 {
                    if let url = URL(string: "https://www.lewisu.edu/academics/english/") {
                        UIApplication.shared.open(url)
                    }
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://www.lewisu.edu/academics/english/")
                } else if indexPath.item == 5 {
                    if let url = URL(string: "https://www.lewisu.edu/academics/foreignlang/index.htm") {
                        UIApplication.shared.open(url)
                    }
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://www.lewisu.edu/academics/foreignlang/index.htm")
                } else if indexPath.item == 6 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://cdncloudfront.com/media/user_space/b19fc423af42/ebook/ebook_1507173593_6145.pdf")
                } else if indexPath.item == 7 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://lewisu.mywconline.com/")
                } else if indexPath.item == 8 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://lewisuwritingcenter.wordpress.com/")
                } else if indexPath.item == 9 {
                    if let url = URL(string: "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506483212333_71") {
                        UIApplication.shared.open(url)
                    }
                } else if indexPath.item == 10 {
                    if let url = URL(string: "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506640344592_71") {
                        UIApplication.shared.open(url)
                    }
                } else if indexPath.item == 11 {
                    if let url = URL(string: "http://www.jetfuelreview.com/") {
                        UIApplication.shared.open(url)
                    }
                    self.homePageController?.showWebForSetting(setting: setting, url: "http://www.jetfuelreview.com/")
                } else if indexPath.item == 12 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://lewislitjournal.wordpress.com/")
                } else if indexPath.item == 13 {
                    if let url = URL(string: "https://www.lewisu.edu/windowsmag/index.htm") {
                        UIApplication.shared.open(url)
                    }
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://www.lewisu.edu/windowsmag/index.htm")
                } else if indexPath.item == 14 {
                    if let url = URL(string: "http://maps.apple.com/?address=650,DelaSalleDr.,60441") {
                        UIApplication.shared.open(url)
                    }
                } else if indexPath.item == 15 {
                    self.homePageController?.showDigitalGallery()
                } else if indexPath.item == 16 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://us21.chatzy.com/66919120381232")
                } else if indexPath.item == 17 {
                    let layout = UICollectionViewFlowLayout()
                    self.homePageController?.navigationController?.pushViewController(ProfessorsViewController(collectionViewLayout: layout), animated: true)
                } else if indexPath.item == 18 {
                    self.homePageController?.showWebForSetting(setting: setting, url: "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506701350955_71")
                } else if indexPath.item == 19 {
                    self.homePageController?.showSettingsController()
                } else {
                    self.homePageController?.showAboutController()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            headerView.frame.size.height = 300
        } else {
            headerView.frame.size.height = 150
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width, height: 300)
        } else {
            return CGSize(width: collectionView.frame.width, height: 150)
        }
    }
}
