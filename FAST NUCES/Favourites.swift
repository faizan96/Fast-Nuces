//
//  Favourites.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation

class Favourites
{
    private var _title: String!
    private var _imageUrl: String!
    private var _postkey: String!
    
    var title : String
    {
        return _title
    }
    
    var imageUrl : String
    {
        return _imageUrl
    }
    
    var postkey : String
    {
        return _postkey
    }
    
    init(postkey: String,title: String,imageUrl: String) {
        
        self._title = title
        self._imageUrl = imageUrl
        self._postkey = postkey
    }
    
}
