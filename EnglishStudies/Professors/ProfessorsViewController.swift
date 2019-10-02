//
//  ProfessorsViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/17/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import Firebase

class ProfessorsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var professors: [String] = []
    var professorSelected: String? = nil
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfessors()
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        
        self.title = "Professors"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView.register(ProfessorCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height / 2.75
        return CGSize(width: view.frame.width - 12, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProfessorCell
        
        let reference = storageRef.child("professorPictures/\(professors[indexPath.item]).png")
        cell.cellImageView.sd_setImage(with: reference)
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 1
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return professors.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProfessorDetailViewController") as! ProfessorDetailViewController
        
        professorSelected = professors[indexPath.item]
        if let professorLast = professorSelected {
            vc.professorLastName = professorLast
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadProfessors() {
        let db = Firestore.firestore()
        let photoRef = db.collection("professors")
        
        photoRef.getDocuments { (querySnapshot, error) in
            if error != nil {
                print("Error")
            } else {
                for document in querySnapshot!.documents {
                    self.professors.append(document.data()["picture"] as! String)
                }
                self.professors = self.professors.sorted(by: <)
                if self.professors.count != 0 {
                    self.collectionView.reloadData()
                } else {
                    let noPhotosLabel = UILabel()
                    noPhotosLabel.text = "No Photos Currently Available"
                    noPhotosLabel.textColor = .lightGray
                    noPhotosLabel.frame = CGRect(x: self.view.center.x / 2.5, y: self.view.center.y / 2, width: self.collectionView.frame.width, height: 100)
                    noPhotosLabel.center.x = self.view.center.x
                    self.view.addSubview(noPhotosLabel)
                }
            }
        }
    }
}
