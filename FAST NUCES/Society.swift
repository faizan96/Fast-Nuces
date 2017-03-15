
//
//  Society.swift
//  FAST NUCES
//
//  Created by Faizan on 14/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation

class Society
{
    private var _title: String!
    private var _imageUrl: String!
    private var _postDesc: String!
    
    var title : String
    {
        return _title
    }
    
    var imageUrl : String
    {
        return _imageUrl
    }
    
    var postDesc : String
    {
        return _postDesc
    }
    
    init(postDesc: String,title: String,imageUrl: String) {
        
        self._title = title
        self._imageUrl = imageUrl
        self._postDesc = postDesc
    }






}
