//
//  SignUpVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//Outlets
    @IBOutlet weak var profileImage: RoundedProfileImage!
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









