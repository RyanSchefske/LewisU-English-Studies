//
//  ChatLogInViewController.swift
//  EnglishStudies
//
//  Created by Ryan Schefske on 6/11/19.
//  Copyright © 2019 Ryan Schefske. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatDisplayNameViewController: UIViewController, UITextFieldDelegate {
    
    var textField: UITextField!
    var submitButton: UIButton!
    var signOutButton: UIButton!
    
    let displayName = Auth.auth().currentUser?.displayName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.title = "Chat Login"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        textField = UITextField(frame: CGRect(x: 5, y: view.center.y / 2 - 55, width: view.frame.width - 10, height: 50))
        textField.placeholder = "Display Name"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.contentHorizontalAlignment = .center
        textField.contentVerticalAlignment = .center
        view.addSubview(textField)
        
        submitButton = UIButton(frame: CGRect(x: 5, y: view.center.y / 2, width: view.frame.width - 10, height: 50))
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = UIColor(red:142/255, green:37/255, blue:49/255, alpha: 1.0)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        view.addSubview(submitButton)
        
        signOutButton = UIButton(frame: CGRect(x: 5, y: view.center.y / 2 + 75, width: view.frame.width - 10, height: 50))
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.backgroundColor = UIColor(red:142/255, green:37/255, blue:49/255, alpha: 1.0)
        signOutButton.layer.cornerRadius = 10
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        view.addSubview(signOutButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textField.text = displayName
    }
    
    @objc func submitButtonPressed() {
        
        if let displayName = textField.text {
            if displayName != "" && displayName != " " {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = displayName
                    changeRequest?.commitChanges { (error) in
                    if error != nil {
                        print(error)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
    }
    
    @objc func signOutButtonPressed() {
        do {
            self.navigationController?.popToRootViewController(animated: true)
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }
    
}
