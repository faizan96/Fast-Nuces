//
//  UserVC.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class UserVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableVIew: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var user = [Users]()
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
        
        observeUser()
        
        
    }
    
    
    
    func observeUser()
    {
        ProgressHUD.show()
        AuthService.instance.USERS_REF?.observeSingleEvent(of: .value, with: { (snapshot) in
            if let users = snapshot.value as? Dictionary<String,AnyObject>
            {
                for (_, value) in users
                {
                    if let dict = value as? Dictionary<String,AnyObject>
                    {
                        let imageUrl = dict["profileImg"] as! String
                        let username = dict["username"] as! String
                        let user = Users(username: username, thumbnail: imageUrl)
                        self.user.append(user)
                    }
                    
                }
            }
            self.tableVIew.reloadData()
            ProgressHUD.dismiss()
        })
        
        
        
        
    }

    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableVIew.backgroundView = UIImageView(image: UIImage(named: "main"))
        tableVIew.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let users = user[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsersCell
        cell.configureCell(users: users)
        return cell
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    

}
