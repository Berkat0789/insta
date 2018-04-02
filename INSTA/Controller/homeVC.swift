//
//  homeVC.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit
import Firebase

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
        cell.updateCell(post: post)
        return cell
    }
    
}
