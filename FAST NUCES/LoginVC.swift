//
//  LoginVC.swift
//  FAST NUCES
//
//  Created by Faizan on 21/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import FirebaseAuth
import ProgressHUD
import SCLAlertView

class LoginVC: UIViewController {

    @IBOutlet weak var passwordField: DesignableTextField!
    @IBOutlet weak var emailField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerEmail.backgroundColor = UIColor.white.cgColor
        emailField.layer.addSublayer(bottomLayerEmail)
       
    
        let bottomLayerPass = CALayer()
        bottomLayerPass.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerPass.backgroundColor = UIColor.white.cgColor
        passwordField.layer.addSublayer(bottomLayerPass)
        
        
        
        
    }

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        ProgressHUD.show("Please wait.....")
        
        if let email = emailField.text, !email.isEmpty , let password = passwordField.text, !password.isEmpty
        {
            AuthService.instance.login(email: email, password: password, onComplete: { (errMsg, data) in
                
                guard errMsg == nil else
                {
                    ProgressHUD.dismiss()
                    SCLAlertView().showWarning("Error Authentication", subTitle: errMsg!)
                    return
                }
                ProgressHUD.dismiss()
                AuthService.instance.switchNav()            })
            
        }
        else
        {
            ProgressHUD.dismiss()
            SCLAlertView().showWarning("Email & Password", subTitle: "You must enter email and password")
        }
    }
    
    
    @IBAction func forgetPwdTapped(_ sender: Any) {
    }
    
    

}
