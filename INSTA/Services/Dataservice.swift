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
    private(set) public var firebaseREF_post = firebase_REf.child("post")


//Storage references
    private(set) public var Firebade_Store = firebase_Storg
    private(set) public var Firebade_Store_profileImgaes = firebase_Storg.child("profileImages")
    private(set) public var Firebade_Store_postImages = firebase_Storg.child("postImages")


    

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
    
//--Add post to DB
    func addPosttoDB(senderID: String, postImage: UIImage, postCaption: String, completed: @escaping (_ status: Bool) -> ()) {
        let imageData = UIImageJPEGRepresentation(postImage, 0.2)
        Firebade_Store_postImages.putData(imageData!, metadata: nil) { (metadata, error) in
            if error != nil {
                print("error")
            } else {
                let imageURL = metadata?.downloadURL()?.absoluteString
                self.firebaseREF_post.childByAutoId().updateChildValues(["postImage": imageURL!, "postCaption": postCaption, "senderID" :senderID])
            }
        }
    }
    
//--Get all post
    
    func getAllPosts(compelted: @escaping (_ posts: [Post]) -> ()) {
        var allPost = [Post]()
        firebaseREF_post.observeSingleEvent(of: DataEventType.value) { (postSnap) in
            guard let postSnap = postSnap.children.allObjects as? [DataSnapshot] else {return}
            for post in postSnap {
                let caption = post.childSnapshot(forPath: "postCaption").value as! String
                let imageURl = post.childSnapshot(forPath: "postImage").value as! String
                let posts = Post(imageURL: imageURl, caption: caption)
                allPost.append(posts)
            }
            compelted(allPost)
        }
    }
    
    
}
