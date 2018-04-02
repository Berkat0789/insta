//
//  Post.swift
//  INSTA
//
//  Created by berkat bhatti on 4/1/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import UIKit


class Post {
    
    private(set) public var postImageURL: String!
    private(set) public var Caption: String!
    
    init(imageURL: String, caption: String) {
        self.postImageURL = imageURL
        self.Caption = caption
    }
}
