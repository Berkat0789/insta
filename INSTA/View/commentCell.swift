//
//  commentCell.swift
//  INSTA
//
//  Created by berkat bhatti on 4/2/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit

class commentCell: UITableViewCell {
    @IBOutlet weak var userProfile: RoundedProfileImage!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentfield: UILabel!
    
    func updateCell(comment: Comment) {
        self.userProfile.image = UIImage(named: "blank_profile")
        self.userName.text = comment.userID
        self.commentfield.text = comment.commentMessage
    }

}
