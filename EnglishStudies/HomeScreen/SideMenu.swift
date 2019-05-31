//
//  SideMenu.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/23/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class SideMenu: NSObject {
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuCollectionViewCell
        
        if indexPath.row == 0 {
            cell.image.image = UIImage(named: "NewsEvents")
            cell.nameLabel.text = "News and Events"
        } else if indexPath.row == 1 {
            cell.image.image = UIImage(named: "EnglishFacebook")
            cell.nameLabel.text = "English Studies on Facebook"
        } else if indexPath.row == 2 {
            cell.image.image = UIImage(named: "WorldLanguages")
            cell.nameLabel.text = "World Languages Program"
        } else if indexPath.row == 3 {
            cell.image.image = UIImage(named: "EnglishStudiesOnline")
            cell.nameLabel.text = "The English Department"
        } else if indexPath.row == 4 {
            cell.image.image = UIImage(named: "WritingCenter")
            cell.nameLabel.text = "Writing Center"
        } else if indexPath.row == 5 {
            cell.image.image = UIImage(named: "OWL")
            cell.nameLabel.text = "OWL"
        } else if indexPath.row == 6 {
            cell.image.image = UIImage(named: "JetFuel")
            cell.nameLabel.text = "Jet Fuel Review"
        } else if indexPath.row == 7 {
            cell.image.image = UIImage(named: "JetFuelBlog")
            cell.nameLabel.text = "Jet Fuel Blog"
        } else if indexPath.row == 8 {
            cell.image.image = UIImage(named: "WindowsFineArts")
            cell.nameLabel.text = "Windows Fine Arts Magazine"
        } else if indexPath.row == 9 {
            cell.image.image = UIImage(named: "DeLasalle")
            cell.nameLabel.text = "Romeoville Campus on GPS"
        } else if indexPath.row == 10 {
            cell.image.image = UIImage(named: "DigitalGallery")
            cell.nameLabel.text = "A Digital Gallery"
        } else if indexPath.row == 11 {
            cell.image.image = UIImage(named: "CornerChatRoom")
            cell.nameLabel.text = "Chat Room"
        } else if indexPath.row == 12 {
            cell.image.image = UIImage(named: "Professors")
            cell.nameLabel.text = "Professors"
        } else if indexPath.row == 13 {
            cell.image.image = UIImage(named: "EnglishFacebook")
            cell.nameLabel.text = "Settings"
        } else if indexPath.row == 14 {
            cell.image.image = UIImage(named: "EnglishFacebook")
            cell.nameLabel.text = "About"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            passedTitle = "News and Events"
            passedUrl = "https://luenglishstudies.blogspot.com/2017/11/blog-post.html?m=1"
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 1 {
            passedTitle = "English Studies Facebook"
            passedUrl = "https://www.facebook.com/LUEnglishStudies/"
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 2  {
            passedTitle = "World Language Program"
            passedUrl = "https://www.lewisu.edu/academics/foreignlang/index.htm"
            if let url = URL(string: passedUrl!) {
                UIApplication.shared.open(url)
            }
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 3  {
            passedTitle = "English Studies Online"
            passedUrl = "https://www.lewisu.edu/academics/english/"
            if let url = URL(string: passedUrl!) {
                UIApplication.shared.open(url)
            }
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 4 {
            passedTitle = "Writing Center"
            passedUrl = "https://lewisu.mywconline.com/"
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 5 {
            passedTitle = "Online Writing Center"
            passedUrl = "https://lewisuwritingcenter.wordpress.com/"
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 6 {
            passedTitle = "Jet Fuel Review"
            passedUrl = "http://www.jetfuelreview.com/"
            if let url = URL(string: passedUrl!) {
                UIApplication.shared.open(url)
            }
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 7 {
            passedTitle = "Jet Fuel Blog"
            passedUrl = "https://lewislitjournal.wordpress.com/"
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 8 {
            passedTitle = "Windows Fine Arts Magazine"
            passedUrl = "https://www.lewisu.edu/windowsmag/index.htm"
            if let url = URL(string: passedUrl!) {
                UIApplication.shared.open(url)
            }
            performSegue(withIdentifier: "showWebView", sender: self)
        } else if indexPath.row == 9 {
            if let url = URL(string: "http://maps.apple.com/?address=650,DelaSalleDr.,60441") {
                UIApplication.shared.open(url)
            }
        } else if indexPath.row == 12 {
            performSegue(withIdentifier: "showProfessors", sender: self)
        }
    }
}
