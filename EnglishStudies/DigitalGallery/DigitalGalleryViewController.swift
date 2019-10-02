//
//  DigitalGalleryViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/6/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class DigitalGalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var photos: [String] = []
    private let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPhotos()
        
        collectionView.backgroundColor = .white
        collectionView.register(DigitalCell.self, forCellWithReuseIdentifier: "cellId")
        
        navigationItem.title = "Digital Gallery"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DigitalCell
        
        let reference = storageRef.child("images/\(photos[indexPath.item])")
        cell.cellImageView.sd_setImage(with: reference)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageZoom = ImageZoomViewController()
        imageZoom.selectedPhoto = photos[indexPath.item]
        navigationController?.pushViewController(imageZoom, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGSize(width: collectionView.frame.width / 3.2, height: 300)
        } else {
            return CGSize(width: collectionView.frame.width / 3.2, height: 150)
        }
    }
    
    func loadPhotos() {
        let photoRef = db.collection("images")
        
        photoRef.getDocuments { (querySnapshot, error) in
            if error != nil {
                print("Error")
            } else {
                for document in querySnapshot!.documents {
                    self.photos.append(document.data()["name"] as! String)
                }
                
                if self.photos.count != 0 {
                    self.collectionView.reloadData()
                } else {
                    let noPhotosLabel = UILabel()
                    noPhotosLabel.text = "No Photos Currently Available"
                    noPhotosLabel.textAlignment = .center
                    noPhotosLabel.textColor = .lightGray
                    noPhotosLabel.frame = CGRect(x: self.view.center.x / 2.5, y: self.view.center.y / 2, width: self.collectionView.frame.width, height: 100)
                    noPhotosLabel.center.x = self.view.center.x
                    self.view.addSubview(noPhotosLabel)
                }
            }
        }
    }
    
}
