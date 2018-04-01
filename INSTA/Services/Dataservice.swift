//
//  Dataservice.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase

let firebase_REf = Database.database().reference()
let firebase_Storg = Storage.storage().reference()

class dataService {
    static let instance = dataService()

//DB References
    private(set) public var Firebase_REference = firebase_REf
    private(set) public var firebaseREF_Users = firebase_REf.child("users")

//Storage references
    private(set) public var Firebade_Store = firebase_Storg
    private(set) public var Firebade_Store_profileImgaes = firebase_Storg.child("profileImages")

    

//Add user to Database
    func registerUsertoFB(uid: String, username: String, email: String, profile: UIImage, completed: @escaping (_ status: Bool) -> ()) {
        let profileImageData = UIImageJPEGRepresentation(profile, 0.3)
        Firebade_Store_profileImgaes.putData(profileImageData!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("Error")
            } else {
                let imageURL = metadata?.downloadURL()?.absoluteString
                self.firebaseREF_Users.child(uid).updateChildValues(["email": email, "username": username, "profileimg": imageURL!])
            }
            completed(true)
        }
    }
    
}
