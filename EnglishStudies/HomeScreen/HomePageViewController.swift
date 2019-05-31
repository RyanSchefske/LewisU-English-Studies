//
//  HomePageViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/15/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableOutlet: UITableView!
    
    var passedTitle: String? = ""
    var passedUrl: String? = ""
    var hamburgerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(dismissMenu))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let window = UIApplication.shared.keyWindow {
            self.collectionView.frame = CGRect(x: -window.frame.width, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            return 500
        } else {
            return 233
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.cellImage.image = UIImage(named: "NewsEvents")
            cell.cellTitle.text = "News and Events"
            cell.cellLabel.text = "Your Personal Invitation to Join Your Friends and Professors"
        } else if indexPath.row == 1 {
            cell.cellImage.image = UIImage(named: "EnglishFacebook")
            cell.cellTitle.text = "English Studies on Facebook"
        } else if indexPath.row == 2 {
            cell.cellImage.image = UIImage(named: "WorldLanguages")
            cell.cellTitle.text = "World Language Program"
            cell.cellLabel.text = "Find information on the multitude of languages we study here at Lewis-Grow Your Brain!"
        } else if indexPath.row == 3 {
            cell.cellImage.image = UIImage(named: "EnglishStudiesOnline")
            cell.cellTitle.text = "The English Department Online"
        } else if indexPath.row == 4 {
            cell.cellImage.image = UIImage(named: "WritingCenter")
            cell.cellTitle.text = "Writing Center"
            cell.cellLabel.text = "Make an appointment with a tutor to review and revise your paper for every course."
        } else if indexPath.row == 5 {
            cell.cellImage.image = UIImage(named: "OWL")
            cell.cellTitle.text = "OWL - Online Writing Center"
            cell.cellLabel.text = "Your online writing handbook, providing guides and resources for writing in every form."
        } else if indexPath.row == 6 {
            cell.cellImage.image = UIImage(named: "JetFuel")
            cell.cellTitle.text = "Jet Fuel Review"
            cell.cellLabel.text = "A bi-annual, student-run literary journal"
        } else if indexPath.row == 7 {
            cell.cellImage.image = UIImage(named: "JetFuelBlog")
            cell.cellTitle.text = "The Jet Fuel Blog"
            cell.cellLabel.text = "A High-Octane Literary Blog"
        } else if indexPath.row == 8 {
            cell.cellImage.image = UIImage(named: "WindowsFineArts")
            cell.cellTitle.text = "Windows Fine Arts Magazine"
            cell.cellLabel.text = "An annual publication that highlights the creative talents of members at Lewis."
        } else if indexPath.row == 9 {
            cell.cellImage.image = UIImage(named: "DeLasalle")
            cell.cellTitle.text = "Romeoville Campus on GPS"
            cell.cellLabel.text = "Find your way to department offices or classrooms."
        } else if indexPath.row == 10 {
            cell.cellImage.image = UIImage(named: "DigitalGallery")
            cell.cellTitle.text = "A Digital Gallery"
            cell.cellLabel.text = "Photos taken during department events"
        } else if indexPath.row == 11 {
            cell.cellImage.image = UIImage(named: "CornerChatRoom")
            cell.cellTitle.text = "A Chat Room for Students"
            cell.cellLabel.text = "A chat room for students using the English Studies at LewisU app."
        } else if indexPath.row == 12 {
            cell.cellImage.image = UIImage(named: "Professors")
            cell.cellTitle.text = "Find Your Professor - Contacts"
            cell.cellLabel.text = "Connect with your professors"
        } else if indexPath.row == 13 {
            cell.cellImage.image = UIImage(named: "Podcasts")
            cell.cellTitle.text = "Find Your Professor - Contacts"
            cell.cellLabel.text = "Connect with your professors"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !hamburgerVisible {
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
            } else if indexPath.row == 13 {
                passedTitle = "Podcasts"
                passedUrl = "https://www.pwastore.com/w/english-studies-at-lewisu/folder_1506701350955_71"
                if let url = URL(string: passedUrl!) {
                    UIApplication.shared.open(url)
                }
                performSegue(withIdentifier: "showWebView", sender: self)
            }
        } else {
            hamburgerClicked(self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebViewController {
            if let url = passedUrl {
                destination.passedUrl = url
            }
            if let title = passedTitle {
                destination.navTitle = title
            }
        }
    }
    
    @IBAction func hamburgerClicked(_ sender: Any) {
        if hamburgerVisible {
            dismissMenu()
        } else {
            respondToSwipe()
        }
    }
    
    @objc func dismissMenu() {
        tableOutlet.isScrollEnabled = true
        tableOutlet.allowsSelection = true
        
        UIView.animate(withDuration: 0.75) {
            if let window = UIApplication.shared.keyWindow {
                self.tableOutlet.alpha = 1
                self.collectionView.frame = CGRect(x: -window.frame.width, y: 0, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
        
        hamburgerVisible = false
    }
    
    @objc func respondToSwipe() {
        tableOutlet.isScrollEnabled = false
        
        if let window = UIApplication.shared.keyWindow {
            let width: CGFloat = window.frame.width / 2
            let x = -window.frame.width / 2 + width
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.tableOutlet.alpha = 0.6
                self.collectionView.frame = CGRect(x: x, y: 0, width: self.collectionView.frame.width, height: window.frame.height)
            }, completion: nil)
        }
        hamburgerVisible = true
    }
    
}
