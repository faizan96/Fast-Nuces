//
//  VC1.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import FirebaseDatabase
import FirebaseAuth

class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let deviceId = UIDevice.current.identifierForVendor?.uuidString
    
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: DesignableImageView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.black
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        
        cell.postImg.image = UIImage(named: "watchkit-intro")
        return cell
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatVC"
        {
//            let cell = sender as! NewsCell
//            let indexpath = tableView.indexPath(for: cell)
//            let room = rooms[(indexpath?.row)!]
//            let chatVC = segue.destination as! ChatVC
//            chatVC.roomid = room.id
            
            
        }
    }
    



    
    
}
