//
//  postCell.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postCaption: UILabel!
    
    func updateCell(post: Post) {
        self.postCaption.text = post.Caption
        self.postImage.image =  UIImage(named: post.postImageURL)
    }
   

}
