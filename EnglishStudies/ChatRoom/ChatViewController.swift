//
//  ChatViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/12/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import Firebase

class ChatViewController: UIViewController {
    
    fileprivate var authHandle: AuthStateDidChangeListenerHandle!
    
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authUI = FUIAuth.defaultAuthUI()
        
        var handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                // Do nothing
            } else {
                authUI?.delegate = self
                authUI?.providers = self.providers
                
                let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
                self.present(authViewController, animated: true, completion: nil)
            }
        }
        
        view.backgroundColor = .white
        navigationItem.title = "Chat"
        
        setupButton()
    }
    
    @objc func settingsSelected() {
        let settingsController = ChatDisplayNameViewController()
        self.navigationController?.pushViewController(settingsController, animated: true)
    }
    
    func setupButton() {
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuBtn.addTarget(self, action: #selector(settingsSelected), for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}

extension ChatViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            print(error)
        }
    }
}

extension FUIAuthBaseViewController{
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = nil
    }
}
