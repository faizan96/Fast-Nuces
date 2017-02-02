//
//  ChatVC.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var feedId : String!
    @IBOutlet weak var msgField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 39, width: 1000, height: 0.8)
        bottomLayerEmail.backgroundColor = UIColor.white.cgColor
        msgField.layer.addSublayer(bottomLayerEmail)
        
        
        
        //self.title = "Chat Room"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "main"))
        tableView.tableFooterView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell2", for: indexPath) as! ChatCell
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
