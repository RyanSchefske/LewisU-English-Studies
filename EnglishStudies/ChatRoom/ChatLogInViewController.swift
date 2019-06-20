//
//  ChatLogInViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/18/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import Firebase

class ChatLogInViewController: UIViewController {
    
    fileprivate var authHandle: AuthStateDidChangeListenerHandle!
    
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
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
    }
    
}

extension ChatLogInViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if error != nil {
            print(error)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

extension FUIAuthBaseViewController{
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.leftBarButtonItem = nil
    }
}
