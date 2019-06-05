//
//  HomePageViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/15/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class HomeItems: NSObject {
    let cellTitle: String
    let cellSubTitle: String
    let imageName: String
    
    init(cellTitle: String, cellSubTitle: String, imageName: String) {
        self.cellTitle = cellTitle
        self.cellSubTitle = cellSubTitle
        self.imageName = imageName
    }
}

class HomePageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let homeItems: [HomeItems] = {
        return [HomeItems(cellTitle: "News and Events", cellSubTitle: "Current Events", imageName: "NewsEvents"), HomeItems(cellTitle: "English Studies Facebook", cellSubTitle: "", imageName: "EnglishFacebook"), HomeItems(cellTitle: "World Language Program", cellSubTitle: "Find information on the multitude of languages we study here at Lewis - Grow Your Brain!", imageName: "WorldLanguages"), HomeItems(cellTitle: "The English Department Online", cellSubTitle: "", imageName: "EnglishStudiesOnline"), HomeItems(cellTitle: "Writing Center", cellSubTitle: "Make an appointment with a tutor to review and revise your paper for every course", imageName: "WritingCenter"), HomeItems(cellTitle: "OWL - Online Writing Center", cellSubTitle: "Your online writing handbook, providing guides and resources for writing in every form", imageName: "OWL"), HomeItems(cellTitle: "Jet Fuel Review", cellSubTitle: "A bi-annual, student-run literary journal", imageName: "JetFuel"), HomeItems(cellTitle: "The Jet Fuel Blog", cellSubTitle: "A High-Octane Literary Blog", imageName: "JetFuelBlog"), HomeItems(cellTitle: "Windows Fine Arts Magazine", cellSubTitle: "An annual publication that highlights the creative talents of members at Lewis", imageName: "WindowsFineArts"), HomeItems(cellTitle: "Romeoville Campus on GPS", cellSubTitle: "Find your way to department offices or classrooms.", imageName: "DeLasalle"), HomeItems(cellTitle: "A Digital Gallery", cellSubTitle: "Photos taken during deparment events", imageName: "DigitalGallery"), HomeItems(cellTitle: "A Chat Room for Students", cellSubTitle: "A chat room for students using the English studies at LewisU app", imageName: "CornerChatRoom"), HomeItems(cellTitle: "Find Your Professor - Contacts", cellSubTitle: "Connect with your professors", imageName: "Professors"), HomeItems(cellTitle: "Podcasts", cellSubTitle: "", imageName: "Podcasts")]
    }()
    
    var passedUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "LewisU English Studies"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.backgroundColor = UIColor(red:142/255, green:37/255, blue:49/255, alpha:1.0)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "cellId")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem?.tintColor = .white
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleMenu))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    lazy var menuLauncher: MenuLauncher = {
        let launcher = MenuLauncher()
        launcher.homePageController = self
        return launcher
    }()
    
    @objc func handleMenu() {
        menuLauncher.showMenu()
    }
    
    func showControllerForSetting(setting: Setting) {
        let settingViewController = UIViewController()
        settingViewController.view.backgroundColor = .white
        settingViewController.navigationItem.title = setting.name
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func showWebController(homeItem: HomeItems, url: String) {
        let webController = WebViewController()
        webController.navigationItem.title = homeItem.cellTitle
        webController.passedUrl = url
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(webController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! HomeCell
        
        let homeItem = homeItems[indexPath.item]
        cell.homeItem = homeItem
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height / 2.5
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = homeItems[indexPath.item]
        if indexPath.item == 0 {
            showWebController(homeItem: itemSelected, url: "https://luenglishstudies.blogspot.com/2017/11/blog-post.html?m=1")
        } else if indexPath.item == 1 {
            showWebController(homeItem: itemSelected, url: "https://www.facebook.com/LUEnglishStudies/")
        } else if indexPath.item == 2 {
            if let url = URL(string: "https://www.lewisu.edu/academics/foreignlang/index.htm") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/academics/foreignlang/index.htm")
        } else if indexPath.item == 3 {
            if let url = URL(string: "https://www.lewisu.edu/academics/english/") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/academics/english/")
        } else if indexPath.item == 4 {
            showWebController(homeItem: itemSelected, url: "https://lewisu.mywconline.com/")
        } else if indexPath.item == 5 {
            showWebController(homeItem: itemSelected, url: "https://lewisuwritingcenter.wordpress.com/")
        } else if indexPath.item == 6 {
            if let url = URL(string: "http://www.jetfuelreview.com/") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "http://www.jetfuelreview.com/")
        } else if indexPath.item == 7 {
            showWebController(homeItem: itemSelected, url: "https://lewislitjournal.wordpress.com/")
        } else if indexPath.item == 8 {
            if let url = URL(string: "https://www.lewisu.edu/windowsmag/index.htm") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/windowsmag/index.htm")
        } else if indexPath.item == 9 {
            if let url = URL(string: "http://maps.apple.com/?address=650,DelaSalleDr.,60441") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.item == 10 { //TODO
            showWebController(homeItem: itemSelected, url: "https://www.facebook.com/LUEnglishStudies/")
        } else if indexPath.item == 11 { //TODO
            showWebController(homeItem: itemSelected, url: "https://www.facebook.com/LUEnglishStudies/")
        } else if indexPath.item == 12 {
            let layout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(ProfessorsViewController(collectionViewLayout: layout), animated: true)
        } else if indexPath.item == 13 {
            if let url = URL(string: "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506701350955_71") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506701350955_71")
        }
    }
}
