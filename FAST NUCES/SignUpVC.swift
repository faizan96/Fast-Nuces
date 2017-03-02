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

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var pickLbl: UILabel!
    @IBOutlet weak var profileImg: DesignableImageView!
    @IBOutlet weak var pwdField: DesignableTextField!
    @IBOutlet weak var emailField: DesignableTextField!
    @IBOutlet weak var usernameField: DesignableTextField!
    
    
    let imagePicker  = UIImagePickerController()
    var selectedPhoto : UIImage!

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
        
        self.imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
  
    @IBAction func signUpTapped(_ sender: Any) {
        
        ProgressHUD.show("Please Wait....")
        
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
    
    

}

extension SignUpVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage
        self.profileImg.image = selectedPhoto
        pickLbl.isHidden = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

