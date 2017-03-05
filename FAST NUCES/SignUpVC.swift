//
//  SignUpVC.swift
//  FAST NUCES
//
//  Created by Faizan on 21/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import ProgressHUD
import SCLAlertView
import Lightbox
import ImagePicker


class SignUpVC: UIViewController,ImagePickerDelegate {
    
    
    @IBOutlet weak var pickLbl: UILabel!
    @IBOutlet weak var profileImg: DesignableImageView!
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpVC.selectPhoto(tap:)))
        tap.numberOfTapsRequired = 1
        profileImg.addGestureRecognizer(tap)
        profileImg.layer.cornerRadius = profileImg.frame.size.height / 2
        profileImg.layer.masksToBounds = true
         
    }
    
    func selectPhoto(tap : UITapGestureRecognizer)
    {
        let imagePicker = ImagePickerController()
        imagePicker.imageLimit = 1
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
  
    @IBAction func signUpTapped(_ sender: Any) {
        
        ProgressHUD.show("Authorizing..")
        
        if let username = usernameField.text , !username.isEmpty, let email = emailField.text, !email.isEmpty , let password = pwdField.text, !password.isEmpty
        {
            var data = NSData()
            data = UIImageJPEGRepresentation(profileImg.image!, 0.1)! as NSData
            
            AuthService.instance.signUp(username: username, email: email, password: password, data: data, onComplete: { (errMsg, data) in
                guard errMsg == nil else
                {
                    ProgressHUD.dismiss()
                    SCLAlertView().showWarning("Error Authentication", subTitle: errMsg!)
                    return
                }
                
                AuthService.instance.switchNav()
            })
            
        }
        else
        {
            ProgressHUD.dismiss()
            SCLAlertView().showWarning("All Fields", subTitle: "You must enter the all fields")
        }
        
        Sound.play(file: "enter.wav")
        
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        print(images.count)
        profileImg.image = images[0]
        pickLbl.isHidden = true
    }
    
    

}



