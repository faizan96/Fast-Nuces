//
//  Carousal.swift
//  FAST NUCES
//
//  Created by Faizan on 26/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation

class Carousal
{
    private var _title: String!
    private var _imageUrl: String!
    
    
    var title : String
    {
        return _title
    }
   
    var imageUrl : String
    {
        return _imageUrl
    }
    
    init(title: String,imageUrl: String) {
       
        self._title = title
        self._imageUrl = imageUrl
    }
    
}
