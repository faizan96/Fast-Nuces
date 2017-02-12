//
//  News.swift
//  FAST NUCES
//
//  Created by Faizan on 09/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation


class News
{
    private var _title: String!
    private var _description : String!
    private var _date : Int!
    private var _details: String!
    private var _imageUrl: String!
    private var _postkey: String!
    
    var title : String
    {
        return _title
    }
    
    var description : String
    {
        return _description
    }
    
    var date : Int
    {
        return _date
    }
    
    var details : String
    {
        return _details
    }
    
    var imageUrl : String
    {
        return _imageUrl
    }
    
    var postkey : String
    {
        return _postkey
    }
    
    init(postkey: String,title: String,description: String,date: Int,details: String,imageUrl: String) {
        
        self._date = date
        self._description = description
        self._details = details
        self._title = title
        self._imageUrl = imageUrl
        self._postkey = postkey
    }

}
