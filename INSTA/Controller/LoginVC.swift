//
//  LoginVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
//Actions
    @IBAction func signUpPressed(_ sender: Any) {
        guard let signupVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC else {return}
        present(signupVC, animated: true, completion: nil)
    }
    

    @IBAction func loginPressed(_ sender: Any) {
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passwordField.text, passwordField.text != "" else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if  error != nil {
                guard let errorMessage = AuthErrorCode(rawValue: error!._code) else {return}
                switch errorMessage {
                case .invalidEmail:
                    print("Invalid Email")
                case .wrongPassword:
                    print("Wrong Password")
                default:
                    print("Wrong login credentials")
                }
            }else {
                let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "TabControllerVC")
                self.present(tabVC!, animated: true, completion: nil)
                
            }
        }
        
    }
}
