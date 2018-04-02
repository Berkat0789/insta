//
//  Constants.swift
//  INSTA
//
//  Created by berkat bhatti on 4/2/18.
//  Copyright © 2018 TKM. All rights reserved.
//

import Foundation
import Firebase

//--USerData

let userID = (Auth.auth().currentUser?.uid)!

//--Completion handlers

typealias completed = (_ status: Bool) -> ()
typealias completedPost = (_ status: [Post]) -> ()
typealias completedIDs = (_ status: [String]) -> ()




