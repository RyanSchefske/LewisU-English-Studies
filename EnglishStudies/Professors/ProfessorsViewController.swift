//
//  ProfessorsViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/17/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class ProfessorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableOutlet: UITableView!
    
    let professors = ["Mishra", "Kukler", "Gettys", "Hu", "Jones", "Kennedy", "Kyburz", "Letcher", "Muench", "Mustafa", "Oelschlegel", "Philippian", "Ross", "White", "Wielgos"]
    var professorSelected: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Professors"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            return 500;
        } else {
            return 216;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProfessorsTableViewCell
        
        cell.cellImage.image = UIImage(named: professors[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        professorSelected = professors[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showProfessorDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ProfessorDetailViewController {
            if let professorLastName = professorSelected {
                destination.professorLastName = professorLastName
            }
        }
    }

}
