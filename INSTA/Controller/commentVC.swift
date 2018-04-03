//
//  commentVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/2/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

class commentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentField: UITextField!
    
////--Vars and arrays
    var Post: Post!
    var postID: String!
    var CommentsForPost = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dataService.instance.getIDFor(post: Post) { (returnedID) in
            self.postID = returnedID
            dataService.instance.firebaseREF_Comment.observe(DataEventType.value, with: { (commentSnap) in
                dataService.instance.getComments(forPostwith: self.postID) { (returnedComments) in
                    self.CommentsForPost = returnedComments
                    self.tableView.reloadData()
                }
            })
        }

    }
//--Actions
    @IBAction func sendPressed(_ sender: Any) {
        guard let comment = commentField.text, commentField.text != "" else {return}
        dataService.instance.addCommentToDB(postID: self.postID, userID: userID, commentText: comment) { (success) in
            if success {
                self.commentField.text = ""
            }
        }
    }
//==Protocol functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentsForPost.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? commentCell else {return UITableViewCell()}
        let comments = CommentsForPost[indexPath.row]
        cell.updateCell(comment: comments)
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
//--View fiunctions
    func initPostData(post: Post) {
        self.Post = post
    }
    
    

}
