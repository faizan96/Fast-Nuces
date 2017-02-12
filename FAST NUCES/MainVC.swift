//
//  MainVC.swift
//  FAST NUCES
//
//  Created by Faizan on 21/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import SCLAlertView

class MainVC: UIViewController,GIDSignInUIDelegate {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID =
        "1075154103681-e9va09nqfimvsgf9f0f5anm7ovstq4mv.apps.googleusercontent.com"
      
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if user != nil
            {
                AuthService.instance.switchNav()
            }
            else
            {
                print("Unauthorized")
            }
        })
    }
    
    @IBAction func gmailTapped(_ sender: Any) {
          GIDSignIn.sharedInstance().signIn()
    }
    

    
   
}
