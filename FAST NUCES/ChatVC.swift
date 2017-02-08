//
//  ChatVC.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ChatVC: JSQMessagesViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 60))
        self.view.addSubview(navBar)
       
        
        let navItem = UINavigationItem(title: "SomeTitle");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil,  action: #selector(ChatVC.cancel));
        navItem.rightBarButtonItem = doneItem;
        navItem.rightBarButtonItem?.tintColor = UIColor.black
        navBar.setItems([navItem], animated: false);

        inputToolbar.contentView.leftBarButtonItem = nil
        
        self.senderId = "1"
        self.senderDisplayName = "Anonymous"
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: navBar, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: navBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 60))
        view.addConstraint(NSLayoutConstraint(item: navBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: navBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: -20))
   
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.backgroundView =  UIImageView(image: UIImage(named: "main"))
        
    }
   
    
    func cancel()
    {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        
    }
    
    

}
