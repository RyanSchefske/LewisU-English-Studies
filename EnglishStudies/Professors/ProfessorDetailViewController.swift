//
//  ProfessorDetailViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/17/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import Firebase

class ProfessorDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var phoneNumberOutlet: UIButton!
    @IBOutlet var emailOutlet: UIButton!
    @IBOutlet var websiteOutlet: UIButton!
    @IBOutlet var bioOutlet: UILabel!
    @IBOutlet var officeOutlet: UIButton!
    
    var professorLastName = ""
    var professor = ["name": "", "phone": "", "email": "", "bio": "", "office": ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails(last: professorLastName)
        
        title = professorLastName
        
        phoneNumberOutlet.layer.cornerRadius = self.phoneNumberOutlet.frame.height / 2
        emailOutlet.layer.cornerRadius = self.emailOutlet.frame.height / 2
        websiteOutlet.layer.cornerRadius = self.websiteOutlet.frame.height / 2
        officeOutlet.layer.cornerRadius = self.officeOutlet.frame.height / 2
    }
    
    @IBAction func callClicked(_ sender: Any) {
        if let phone = professor["phone"] {
            if phone != "" {
                let number = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
                if let url = URL(string: "tel://\(number)") {
                    UIApplication.shared.open(url)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Email not found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func emailClicked(_ sender: Any) {
        if let email = professor["email"] {
            if email != "" {
                if let url = URL(string: "mailto:\(email)") {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Email not found", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func websiteClicked(_ sender: Any) {
        if let url = URL(string: "http://www.lewisu.edu/academics/english") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func officeClicked(_ sender: Any) {
        if let url = URL(string: "http://maps.apple.com/?address=650,DelaSalleDr.,60441") {
            UIApplication.shared.open(url)
        }
    }
    
    func getDetails(last: String) {
        let db = Firestore.firestore()
        _ = db.collection("professors").whereField("picture", isEqualTo: last)
            .getDocuments { (snapshot, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    for document in snapshot!.documents {
                        let data = document.data()
                        self.professor["name"] = data["name"] as? String
                        self.professor["phone"] = data["phoneNumber"] as? String
                        self.professor["email"] = data["email"] as? String
                        self.professor["office"] = data["office"] as? String
                        self.professor["bio"] = data["bio"] as? String
                    }
                    self.title = self.professor["name"]
                    self.phoneNumberOutlet.setTitle(self.professor["phone"], for: .normal)
                    self.emailOutlet.setTitle(self.professor["email"], for: .normal)
                    self.websiteOutlet.setTitle("Website", for: .normal)
                    self.officeOutlet.setTitle(self.professor["office"], for: .normal)
                    self.bioOutlet.text = self.professor["bio"]
                    
                    //self.imageView.image = UIImage(named: self.professorLastName)
                    
                    let storageRef = Storage.storage().reference()
                    let reference = storageRef.child("professorPictures/\(self.professorLastName).png")
                    self.imageView.sd_setImage(with: reference)
                }
        }
    }
    
}
