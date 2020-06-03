//
//  User.swift
//  Chat App
//
//  Created by Wanhar on 03/06/20.
//  Copyright © 2020 Wanhar. All rights reserved.
//

import Foundation

struct User {
    var uid     : String
    var email   : String?
    
    init(uid:String, email:String?) {
        self.uid    = uid
        self.email  = email
    }
}
