//
//  Comment.swift
//  INSTA
//
//  Created by berkat bhatti on 4/2/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
class Comment {
    private(set) public var userID: String!
    private(set) public var commentMessage: String!

    init(userID: String, commentText: String) {
        self.userID = userID
        self.commentMessage = commentText
    }
    
}
