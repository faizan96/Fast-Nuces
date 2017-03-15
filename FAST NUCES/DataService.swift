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
import ProgressHUD

let DB_BASE = FIRDatabase.database().reference()


class DataService{
    
   
   
    private static let _instance = DataService()
    private var _BASE_REF = DB_BASE
    private var _NEWS_REF = DB_BASE.child("newsfeed")
    private var _RECENT_REF = DB_BASE.child("recent")
    private var _STAR_REF = DB_BASE.child("stars")
    private var _MSG_REF = DB_BASE.child("messages")
    private var _FAC_REF = DB_BASE.child("faculty")
    private var _SOC_REF = DB_BASE.child("society")
    
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
    
    var RECENT_REF : FIRDatabaseReference
    {
        return _RECENT_REF
    }
    
    var STAR_REF : FIRDatabaseReference
    {
        return _STAR_REF
    }
    
    var MSG_REF : FIRDatabaseReference
    {
        return _MSG_REF
    }
    
    var FAC_REF : FIRDatabaseReference
    {
        return _FAC_REF
    }
    
    var SOC_REF : FIRDatabaseReference
    {
        return _SOC_REF
    }
    
    
    func CreateMsg(useruid: String,postId: String,content: String)
    {
        
        let idMessage = BASE_REF.child("messages").childByAutoId()
        DataService.instance.MSG_REF.child(idMessage.key).setValue(["message":content,"senderId":useruid])
        DataService.instance.RECENT_REF.child(postId).child("messages").child(idMessage.key).setValue(true)
        
    }
    
    func FetchMsg(postId: String, callback: @escaping (FIRDataSnapshot) -> ())
    {
        DataService.instance.RECENT_REF.child(postId).child("messages").observe(.childAdded, with: { (snapshot) in
           
            ProgressHUD.show("Please Wait...")
           
            DataService.instance._MSG_REF.child(snapshot.key).observe(.value, with: { (shots) in
                
                callback(shots)

            })
            
        })
        
    }
    
}
