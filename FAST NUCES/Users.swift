//
//  Users.swift
//  FAST NUCES
//
//  Created by Faizan on 02/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation

class Users
{
   private var _username: String!
   private var _thumbnail : String!
    
    
    var username : String
    {
        return _username
    }
    
    var thumbnail : String
    {
        return _thumbnail
    }
    
    init(username: String,thumbnail: String) {
        self._username = username
        self._thumbnail = thumbnail
    }
    
    
    
}
