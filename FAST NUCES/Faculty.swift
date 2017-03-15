//
//  Faculty.swift
//  FAST NUCES
//
//  Created by Faizan on 11/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation

class Faculty
{
    
    private var _name: String!
    private var _designation : String!
    private var _thumbnail: String!
    private var _email : String!
    
    var name : String
    {
        return _name
    }
    
    var thumbnail : String
    {
        return _thumbnail
    }
    
    var email : String
    {
        return _email
    }
    
    var designation: String
    {
            return _designation
    }
    
    init(name: String,thumbnail: String,email: String,designation: String) {
        
        self._name = name
        self._thumbnail = thumbnail
        self._email = email
        self._designation = designation
    }
    
    
    
}
