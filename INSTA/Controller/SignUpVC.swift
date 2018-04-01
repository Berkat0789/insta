//
//  SignUpVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//Outlets
    @IBOutlet weak var profileImage: RoundedProfileImage!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passWordField: UITextField!
    
    //Variables
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }//End view did load
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTaptoProfileImage()
    }
    
//Actions
    @IBAction func loginherepressed(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        present(loginVC, animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        guard let username = usernameField.text, usernameField.text != "" else {return}
        guard let email = emailField.text, emailField.text != "" else {return}
        guard let password = passWordField.text, passWordField.text != "" else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                guard let errorMessage = AuthErrorCode(rawValue: error!._code) else {return}
                switch errorMessage {
                case .emailAlreadyInUse:
                    print("Email in use")
                case .weakPassword:
                    print("password Weak")
                default:
                    print("someting went wrong")
                }
            }else {
                dataService.instance.registerUsertoFB(uid: (Auth.auth().currentUser?.uid)!, username: username, email: email, profile: self.selectedImage!, completed: { (success) in
                    if success {
                        guard let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as? homeVC else{return}
                        self.present(homeVC, animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    func addTaptoProfileImage() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true
    }
    
//Selectors
    @objc func profileImageTapped(_ recon: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Select Image Source", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (cameraSelected) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                print("Camera Unavailable")
            }
        }))
        alertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { (photolibSeected) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
//Protcol Funcitons
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        profileImage.image = image
        selectedImage = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
}









