//
//  AuthService.swift
//  FAST NUCES
//
//  Created by Faizan on 01/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD
import UIKit

typealias Completion = (_ errMsg: String?,_ data: AnyObject?) -> Void

class AuthService
{
    private static let _instance = AuthService()
    private var _BASE_REF = FIRDatabase.database().reference()
    private var _USERS_REF = FIRDatabase.database().reference().child("users")
    
    
    static var instance: AuthService
    {
        return _instance
    }
    
    
    
    var CurrentUser: FIRUser?
    {
        return FIRAuth.auth()?.currentUser!
    }
    
    var USERS_REF: FIRDatabaseReference?
    {
        return _USERS_REF
    }
    
    var BASE_REF: FIRDatabaseReference{
        return _BASE_REF
    }
    
    var storageRef : FIRStorageReference
    {
        return FIRStorage.storage().reference()
    }
    
    var fileUrl : String!
    
    func signUp(username:String,email:String,password:String,data:NSData,onComplete: Completion?)
    {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user,error) in
            if let error = error
            {
                self.handleError(error: error as NSError, onComplete: onComplete!)
                print(error.localizedDescription)
                return
            }
            let changeRequest = user?.profileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error
                {
                    
                    print(error.localizedDescription)
                    return
                }
            })
            let filepath = "profileimage/\(user?.uid)"
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            self.storageRef.child(filepath).put(data as Data, metadata: metadata) { metadata, error in
                if let error = error
                {
                    
                    print(error.localizedDescription)
                    return
                }

            let downloadURL = metadata?.downloadURL()?.absoluteString
            self.USERS_REF?.child((user?.uid)!).setValue(["username":username,"email":email,"profileImg":downloadURL])
                
                ProgressHUD.showSuccess("Succeeded.")
                
                onComplete!(nil,user)
                
                
            }
        })
        
        }
    
    
    
    func login(email: String, password: String, onComplete: Completion?)
    {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (
            user, error) in
            if error != nil
            {
                self.handleError(error: error! as NSError, onComplete: onComplete!)
            }
            else
            {
                onComplete!(nil,user)
            }
        })
        
    }
    
    
    
    func handleError(error: NSError,onComplete: Completion)
    {
        print(error.debugDescription)
        
        if let errorCode = FIRAuthErrorCode(rawValue: error._code)
        {
            switch (errorCode) {
            case .errorCodeInvalidEmail:
                onComplete("Invalid Email Address",nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Invalid Password",nil)
                break
            case .errorCodeEmailAlreadyInUse,.errorCodeAccountExistsWithDifferentCredential:
                onComplete("Email Already In Use",nil)
                break
            case .errorCodeWeakPassword:
                onComplete("Your Password is Weak",nil)
                break
            case .errorCodeUserNotFound:
                onComplete("Sorry User Not Found",nil)
                break
                
            default:
                onComplete("Problem in authenticating. Try again Later",nil)
            }
            
        }
        
        
    }
    
    
    func switchNav()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let naviVC = storyboard.instantiateViewController(withIdentifier: "NewsVC") as! SWRevealViewController
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.window?.rootViewController = naviVC
        
      
    }
    

}
