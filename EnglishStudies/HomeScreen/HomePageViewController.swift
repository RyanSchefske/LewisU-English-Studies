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
        return [HomeItems(cellTitle: "News and Events", cellSubTitle: "Current Events", imageName: "NewsEvents"), HomeItems(cellTitle: "English Studies Facebook", cellSubTitle: "", imageName: "Facebook"), HomeItems(cellTitle: "The English Department Online", cellSubTitle: "", imageName: "English"), HomeItems(cellTitle: "World Language Program", cellSubTitle: "Find information on the multitude of languages we study here at Lewis - Grow Your Brain!", imageName: "WorldLanguages"), HomeItems(cellTitle: "Film Studies Program", cellSubTitle: "", imageName: "FilmStudies"), HomeItems(cellTitle: "Writing Center", cellSubTitle: "Make an appointment with a tutor to review and revise your paper for every course", imageName: "WritingCenter"), HomeItems(cellTitle: "OWL - Online Writing Center", cellSubTitle: "Your online writing handbook, providing guides and resources for writing in every form", imageName: "OWL"), HomeItems(cellTitle: "Jet Fuel Review", cellSubTitle: "A bi-annual, student-run literary journal", imageName: "JetFuel"), HomeItems(cellTitle: "The Jet Fuel Blog", cellSubTitle: "A High-Octane Literary Blog", imageName: "JetFuelBlog"), HomeItems(cellTitle: "Windows Fine Arts Magazine", cellSubTitle: "An annual publication that highlights the creative talents of members at Lewis", imageName: "WindowsFineArts"), HomeItems(cellTitle: "Romeoville Campus on GPS", cellSubTitle: "Find your way to department offices or classrooms.", imageName: "DeLasalle"), HomeItems(cellTitle: "A Digital Gallery", cellSubTitle: "Photos taken during department events", imageName: "DigitalGallery"), HomeItems(cellTitle: "A Chat Room for Students", cellSubTitle: "A chat room for students using the English studies at LewisU app", imageName: "CornerChatRoom"), HomeItems(cellTitle: "Find Your Professor - Contacts", cellSubTitle: "Connect with your professors", imageName: "Professors")]
    }()
    
    var passedUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    lazy var menuLauncher: MenuLauncher = {
        let launcher = MenuLauncher()
        launcher.homePageController = self
        return launcher
    }()
    
    @objc func handleMenu() {
        menuLauncher.showMenu()
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
            if let url = URL(string: "https://www.lewisu.edu/academics/english/") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/academics/english/")
        } else if indexPath.item == 3 {
            if let url = URL(string: "https://www.lewisu.edu/academics/foreignlang/index.htm") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/academics/foreignlang/index.htm")
        } else if indexPath.item == 4 {
            showWebController(homeItem: itemSelected, url: "https://cdncloudfront.com/media/user_space/b19fc423af42/ebook/ebook_1507173593_6145.pdf")
        } else if indexPath.item == 5 {
            showWebController(homeItem: itemSelected, url: "https://lewisu.mywconline.com/")
        } else if indexPath.item == 6 {
            showWebController(homeItem: itemSelected, url: "https://lewisuwritingcenter.wordpress.com/")
        } else if indexPath.item == 7 {
            if let url = URL(string: "http://www.jetfuelreview.com/") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "http://www.jetfuelreview.com/")
        } else if indexPath.item == 8 {
            showWebController(homeItem: itemSelected, url: "https://lewislitjournal.wordpress.com/")
        } else if indexPath.item == 9 {
            if let url = URL(string: "https://www.lewisu.edu/windowsmag/index.htm") {
                UIApplication.shared.open(url)
            }
            showWebController(homeItem: itemSelected, url: "https://www.lewisu.edu/windowsmag/index.htm")
        } else if indexPath.item == 10 {
            if let url = URL(string: "http://maps.apple.com/?address=650,DelaSalleDr.,60441") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.item == 11 {
            showDigitalGallery()
        } else if indexPath.item == 12 { 
            showWebController(homeItem: itemSelected, url: "https://us21.chatzy.com/66919120381232")
        } else if indexPath.item == 13 {
            let layout = UICollectionViewFlowLayout()
            navigationController?.pushViewController(ProfessorsViewController(collectionViewLayout: layout), animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.contentView.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.25, 0.25, 0.25)
                
        UIView.animate(withDuration: 0.65) {
            cell.alpha = 1
            cell.contentView.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        }
    }
    
    let imageView = UIImageView()
    var height: CGFloat = 200
    
    func setupView() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            firstLaunchAlert()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            height = 350
        } else {
            height = 200
        }
        
        collectionView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        imageView.image = UIImage.init(named: "EnglishStudies")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        self.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
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
    
    /*
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! HeaderView
        
        headerView.cellImageView.image = UIImage(named: "EnglishStudies")
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            headerView.frame.size.height = 350
        } else {
            headerView.frame.size.height = 200
        }
        
        return headerView
    }
    
    var height: CGFloat = 200
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            height = 350
            return CGSize(width: collectionView.frame.width, height: height)
        } else {
            height = 200
            return CGSize(width: collectionView.frame.width, height: height)
        }
    } */
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: Int = Int(height - (scrollView.contentOffset.y + height))
        var max = 400
        if UIDevice.current.userInterfaceIdiom == .pad {
            max = 750
        }
        let heightFrame: Int = min(y, max)
        
        if heightFrame >= 0 && heightFrame < (max / 2) {
            let alphaFloat: Float = (Float(heightFrame) / Float(max)) * Float(2)
            imageView.alpha = CGFloat(alphaFloat)
        } else if heightFrame < 0 {
            imageView.alpha = 0
        } else {
            imageView.alpha = 1
        }
        
        imageView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.size.width), height: heightFrame)
    }
    
    func showWebForSetting(setting: Setting, url: String) {
        let webController = WebViewController()
        webController.navigationItem.title = setting.name
        webController.passedUrl = url
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(webController, animated: true)
    }
    
    func showWebController(homeItem: HomeItems, url: String) {
        let webController = WebViewController()
        webController.navigationItem.title = homeItem.cellTitle
        webController.passedUrl = url
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(webController, animated: true)
    }
    
    func showSettingsController() {
        let settingsController = SettingsViewController()
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    func showDigitalGallery() {
        let digitalGalleryController = DigitalGalleryViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(digitalGalleryController, animated: true)
    }
    
    func showAboutController() {
        let aboutController = AboutViewController()
        navigationController?.pushViewController(aboutController, animated: true)
    }
    
    func firstLaunchAlert() {
        let alert = UIAlertController(title: "Terms Of Use", message: """
            Terms of Use For English Studies at LewisU App

            Please read these terms and conditions (‘terms’, ‘terms and conditions’) carefully before using English Studies at LewisU app (the ‘service’) operated by English Studies at LewisU (‘us’, ‘we’, ‘our’).

            Conditions of Use:
            We will provide their services to you, which are subject to the conditions stated below in this document. Every time you visit this app, use its services or make a purchase, you accept the following conditions. This is why we urge you to read them carefully.

            Privacy Policy:
            Before you continue using our app, we advise you read our privacy policy regarding our user data collection. It will help you better understand our practices.

            Copyright:
            Content published on this app (digital downloads, images, texts, graphics, logos) is the property of English Studies at LewisU and/or its content creators and protects by international copyright laws. The entire compilation of the content found on this app is the exclusive property of English Studies at LewisU, with copyright authorship for this compilation by English Studies at LewisU.

            Communications:
            The entire communication with us is electronic. Every time you send us an email or visit our app, you are going to be communicating with us. You hereby consent to receive communications from us. I you subscribe to the news on our app, you are going to receive regular emails from us. We will continue to communicate with you by posting news and notices on our app and by sending you emails. You also agree that all notices, disclosures, agreements, and other communications we provide to you electronically meet the legal requirements that such communications be in writing.

            Applicable Law:
            By visiting this app, you agree that the laws of our country, without regard to principles of conflict laws, will govern these terms and conditions, or any dispute of any sort that might come between English Studies at LewisU and you, or its business partners and associates.

            Disputes:
            Any dispute related in any way to your visit to this app or to products you purchase from us shall be arbitrated by state or federal court of our country and you consent to exclusive jurisdiction and venue of such courts.

            Comments, Reviews, and Emails:
            Visitors may post content as long as it is not obscene, illegal, defamatory, threatening, infringing of intellectual property rights, invasive of privacy, or injurious in any other way to third parties. Content has to be free of software viruses, political campaign, and commercial solicitation. We reserve all rights (but not the obligation) to remove and/or edit such content. When you post your content, you grant English Studies at LewisU non-exclusive, royalty-free and irrevocable right to use, reproduce, publish, and modify such content throughout the world in any media.

            License and Site Access:
            We grant you a limited license to access and make personal use of this app. You are allowed to download it but not misuse it.

            User Account:
            If you are an owner of an account on this app, you are solely responsible for maintaining the confidentiality of your private user details (username and password). You are responsible for all activities that occur under you account or password. We reserve all rights to terminate accounts, edit or remove content, and cancel orders in their sole discretion.
            """, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Agree", style: .default, handler: { (action) in
        }))
        
        //If user declines, alert will be shown again
        alert.addAction(UIAlertAction(title: "Decline", style: .default, handler: { (action) in
            self.firstLaunchAlert()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
