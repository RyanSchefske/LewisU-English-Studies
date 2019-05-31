//
//  ProfessorDetailViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/17/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class ProfessorDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var phoneNumberOutlet: UIButton!
    @IBOutlet var emailOutlet: UIButton!
    @IBOutlet var websiteOutlet: UIButton!
    @IBOutlet var bioOutlet: UILabel!
    @IBOutlet var officeOutlet: UIButton!
    
    var professorLastName = ""
    var professorName = ""
    var phoneNumber = ""
    var number = ""
    var email = ""
    var bio = ""
    var office = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        professorName = getInfo(professor: professorLastName).name
        if professorName != "" {
            self.title = professorName
        } else {
            self.title = "Details"
        }
        
        phoneNumber = getInfo(professor: professorLastName).phoneNumber
        number = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        email = getInfo(professor: professorLastName).email
        office = getInfo(professor: professorLastName).office
        bio = getInfo(professor: professorLastName).bio
        
        phoneNumberOutlet.setTitle(phoneNumber, for: .normal)
        emailOutlet.setTitle(email, for: .normal)
        websiteOutlet.setTitle("Website", for: .normal)
        officeOutlet.setTitle(office, for: .normal)
        bioOutlet.text = bio
        imageView.image = UIImage(named: professorLastName)
        
        phoneNumberOutlet.layer.cornerRadius = self.phoneNumberOutlet.frame.height / 2
        emailOutlet.layer.cornerRadius = self.emailOutlet.frame.height / 2
        websiteOutlet.layer.cornerRadius = self.websiteOutlet.frame.height / 2
        officeOutlet.layer.cornerRadius = self.officeOutlet.frame.height / 2
    }
    
    @IBAction func callClicked(_ sender: Any) {
        if let url = URL(string: "tel://\(self.number)") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func emailClicked(_ sender: Any) {
        if let url = URL(string: "mailto:\(getInfo(professor: professorLastName).email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
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
    
}

func getInfo(professor: String) -> (name: String, phoneNumber: String, email: String, bio: String, office: String) {
    var name: String = ""
    var phoneNumber: String = ""
    var email: String = ""
    var bio: String = ""
    var office: String = ""
    
    if professor == "Mishra" {
        name = "Dr. Pramod Mishra"
        phoneNumber = "(815) 836-5016"
        email = "mishrapr@lewisu.edu"
        bio = "Dr. Mishra is the Chair of the department, handling department business and student advising."
        office = "DL-221-N"
    } else if professor == "Kukler" {
        name = "Dr. Jennifer Consilio Kukler"
        phoneNumber = "(815) 836-5727"
        email = "consilje@lewisu.edu"
        bio = "Director of the Writing Center"
        office = "Library - Writing Center"
    } else if professor == "Gettys" {
        name = "Dr. Serafima Gettys"
        phoneNumber = "(815) 836-5544"
        email = "gettyse@lewisu.edu"
        bio = "Director of Foreign Language Program."
        office = "MC-005"
    } else if professor == "Hu" {
        name = "Ms. Lifeng Hu"
        phoneNumber = "(815) 836-5319"
        email = "huli@lewisu.edu"
        bio = "Assistant Professor"
        office = "MC-006"
    } else if professor == "Jones" {
        name = "Ms. Therese Jones"
        phoneNumber = "(815) 836-5321"
        email = "jonesth@lewisu.edu"
        bio = "Director of Writing Placement. Editor and Coordinator of Windows Fine Arts Magazine."
        office = "DL-206-N"
    } else if professor == "Kennedy" {
        name = "Dr. Sheila Kennedy"
        phoneNumber = "(815) 836-5580"
        email = "kennedsh@lewisu.edu"
        bio = "Director of First Year Writing"
        office = "DL-214-N"
    } else if professor == "Kyburz" {
        name = "Dr. Bonnie Lenore Kyburz"
        phoneNumber = "(815) 836-5565"
        email = "kyburzbl@lewisu.edu"
        bio = "Assistant Professor"
        office = "DL-211-N"
    } else if professor == "Letcher" {
        name = "Dr. Mark Letcher"
        phoneNumber = "(815) 836-5601"
        email = "letchema@lewisu.edu"
        bio = "Assistant Professor"
        office = "DL-215-N"
    } else if professor == "Muench" {
        name = "Dr. Simone Muench"
        phoneNumber = "(815) 836-5554"
        email = "muenchsi@lewisu.edu"
        bio = "Director of Creative Writing"
        office = "DL-216-N"
    } else if professor == "Mustafa" {
        name = "Dr. Jamil Mustafa"
        phoneNumber = "(815) 836-5691"
        email = "mustafja@lewisu.edu"
        bio = "Professor"
        office = "DL-208-N"
    } else if professor == "Oelschlegel" {
        name = "Dr. Lawrence Oelschlegel"
        phoneNumber = "(815) 836-5506"
        email = "oelschla@lewisu.edu"
        bio = "Professor"
        office = "DL-204-N"
    } else if professor == "Philippian" {
        name = "Dr. Mardy Philippian"
        phoneNumber = "(815) 836-5287"
        email = "philipmd@lewisu.edu"
        bio = "Assistant Professor"
        office = "DL-212-N"
    } else if professor == "Ross" {
        name = "Dr. Wallace Ross"
        phoneNumber = "(815) 836-5122"
        email = "rosswa@lewisu.edu"
        bio = "Assistant Professor"
        office = "DL-209-N"
    } else if professor == "White" {
        name = "Dr. Jackie White"
        phoneNumber = "(815) 836-5492"
        email = "whiteja@lewisu.edu"
        bio = "Professor"
        office = "DL-217-N"
    } else if professor == "Wielgos" {
        name = "Dr. Christopher Wielgos"
        phoneNumber = "(815) 836-5873"
        email = "wielgoch@lewisu.edu"
        bio = "Director of Film Studies and Director of Pedagogical Technologies"
        office = "DL-218-N"
    }
    
    return (name, phoneNumber, email, bio, office)
}
