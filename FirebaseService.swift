//
//  FirebaseService.swift
//
//  Created by Bill Golembieski on 03/13/2016
//  Email: BillGolembieski@projectu23.com
//  Copywrite © 2016 Bill Golembieski. All rights Reserved.

import Foundation
import Firebase

let BASE_URL = "https://enteryourfirebaseurlhere.firebaseio.com"

let FIREBASE_REF = Firebase(url: BASE_URL)

var CURRENT_USER: Firebase
{
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
    
    let currentUser = Firebase(url: "\
        (FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
    
    return currentUser
    
}
