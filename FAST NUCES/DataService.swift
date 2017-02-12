//
//  DataService.swift
//  FAST NUCES
//
//  Created by Faizan on 02/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class DataService{
    
    private static let _instance = DataService()
    private var _BASE_REF = FIRDatabase.database().reference()
    private var _NEWS_REF = FIRDatabase.database().reference().child("newsfeed")
    
    static var instance: DataService
    {
        return _instance
    }
    
    var CurrentUser: FIRUser?
    {
        return FIRAuth.auth()?.currentUser!
    }
    
    
    var BASE_REF: FIRDatabaseReference{
        return _BASE_REF
    }
    
    
    var NEWS_REF : FIRDatabaseReference
    {
        return _NEWS_REF
    }
    
}
