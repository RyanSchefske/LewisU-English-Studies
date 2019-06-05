//
//  ProfessorsViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 5/17/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit

class ProfessorsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let professors = ["Mishra", "Kukler", "Gettys", "Hu", "Jones", "Kennedy", "Kyburz", "Letcher", "Muench", "Mustafa", "Oelschlegel", "Philippian", "Ross", "White", "Wielgos"]
    var professorSelected: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(red:142/255, green:37/255, blue:49/255, alpha:1.0)
        
        self.title = "Professors"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView.register(ProfessorCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.height / 2.5
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ProfessorCell
        cell.cellImageView.image = UIImage(named: professors[indexPath.item])
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
}
