//
//  SignUpVC.swift
//  FAST NUCES
//
//  Created by Faizan on 21/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var pwdField: DesignableTextField!
    @IBOutlet weak var emailField: DesignableTextField!
    @IBOutlet weak var usernameField: DesignableTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerEmail.backgroundColor = UIColor.white.cgColor
        emailField.layer.addSublayer(bottomLayerEmail)
        
        let bottomLayerPass = CALayer()
        bottomLayerPass.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerPass.backgroundColor = UIColor.white.cgColor
        pwdField.layer.addSublayer(bottomLayerPass)
        
        let bottomLayerUser = CALayer()
        bottomLayerUser.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerUser.backgroundColor = UIColor.white.cgColor
        usernameField.layer.addSublayer(bottomLayerUser)
         
    }

    @IBAction func cancelTapped(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
  

}
