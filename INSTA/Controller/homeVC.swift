//
//  homeVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import AlamofireImage

class homeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
 //Var
    var allPosts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
////        tableView.estimatedRowHeight = 442
//        tableView.rowHeight = UITableViewAutomaticDimension
    }//--End view did load
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataService.instance.getAllPosts { (returnedPosts) in
            self.allPosts = returnedPosts.reversed()
            self.tableView.reloadData()
        }
    }
//--Actions
    @IBAction func logoutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error)
        }
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {return}
        present(loginVC, animated: true, completion: nil)
    }
//Protocol functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? postCell else {return UITableViewCell()}
        let post = allPosts[indexPath.row]
        cell.postCaption.text = post.Caption
        Alamofire.request(post.postImageURL).responseImage { (response) in
            guard let image = response.result.value else {return}
            DispatchQueue.main.async {
                cell.postImage.image = image
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentVC = storyboard?.instantiateViewController(withIdentifier: "commentVC") as? commentVC else {return}
        let post = allPosts[indexPath.row]
        commentVC.initPostData(post: post)
        present(commentVC, animated: true, completion: nil)
    }
    
}
