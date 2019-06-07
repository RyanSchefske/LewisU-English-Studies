//
//  SettingsViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableCell.self, forCellReuseIdentifier: "cellId")
        
        setupView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Terms of Use"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Privacy Policy"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let url = URL(string: "https://www.pwastore.com/w/english-studies-at-lewisu/terms-of-use"){
                UIApplication.shared.open(url)
            }
        } else if indexPath.row == 1 {
            if let url = URL(string: "https://www.pwastore.com/w/english-studies-at-lewisu/privacy-policy"){
                UIApplication.shared.open(url)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func setupView() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = "Settings"
        view.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
}
