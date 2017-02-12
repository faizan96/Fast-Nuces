//
//  Users.swift
//  FAST NUCES
//
//  Created by Faizan on 02/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Users
{
    
    private var _username: String!
    private var _thumbnail : String!
    private var _email : String!
    
    var username : String
    {
        return _username
    }
    
    var thumbnail : String
    {
        return _thumbnail
    }
    
    var email : String
    {
        return _email
    }
    
    init(username: String,thumbnail: String,email: String) {
        
        self._username = username
        self._thumbnail = thumbnail
        self._email = email
    }
    

    
}
