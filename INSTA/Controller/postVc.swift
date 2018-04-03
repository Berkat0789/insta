//
//  postVc.swift
//  INSTA
//
//  Created by berkat bhatti on 4/2/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class postVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imagepPickerButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var captionfield: UITextField!
    
    var SelectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//---Protocol
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {return}
        imagepPickerButton.setImage(image, for: UIControlState.normal)
        SelectedImage = image
        dismiss(animated: true, completion: nil)
    }
    
//--Actions
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let PostImage = SelectedImage, SelectedImage != nil else {return}
        guard let caption = captionfield.text, captionfield.text != "" else {return}
        dataService.instance.addPosttoDB(senderID: userID, postImage: PostImage, postCaption: caption) { (success) in
            if success {
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        
        let AlertController = UIAlertController(title: "Select image Source", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        AlertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (cameraSelected) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                imagepicker.sourceType = .camera
                self.present(imagepicker, animated: true, completion: nil)
            }
        }))
        AlertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { (librarySelected) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                imagepicker.sourceType = .photoLibrary
                self.present(imagepicker, animated: true, completion: nil)
            }
        }))
        AlertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(AlertController, animated: true, completion: nil)
    }
    
//-View update

    
    
}
