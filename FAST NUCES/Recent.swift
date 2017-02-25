//
//  Recent.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Recent
{
    private var _title: String!
    private var _description : String!
    private var _imageUrl: String!
    private var _postkey: String!
    private var _star: Int!
    private var _comment: Int!
    private var _postRef: FIRDatabaseReference!
    
    var title : String
    {
        return _title
    }
    
    var description : String
    {
        return _description
    }
    
   
    var imageUrl : String
    {
        return _imageUrl
    }
    
    var postkey : String
    {
        return _postkey
    }
    
    var star : Int
    {
        return _star
    }
    
    var comment : Int
    {
        return _comment
    }
    
    init(postkey: String,title: String,description: String,imageUrl: String,star: Int,comment: Int) {
        
        self._description = description
        self._title = title
        self._imageUrl = imageUrl
        self._postkey = postkey
        self._star = star
        self._comment = comment
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postkey = postKey
        
        if let title = postData["title"] as? String {
            self._title = title
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let star = postData["star"] as? Int {
            self._star = star
        }
        
        if let comment = postData["comments"] as? Int {
            self._comment = comment
        }
        
        if let description = postData["description"] as? String {
            self._description = description
        }
        
        _postRef = DataService.instance.RECENT_REF.child(_postkey)
        
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _star = _star + 1
        } else {
            _star = star - 1
        }
        _postRef.child("star").setValue(_star)
        
    }
    
}
