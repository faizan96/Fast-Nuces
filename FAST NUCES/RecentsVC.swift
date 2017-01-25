//
//  RecentsVC.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class RecentsVC: UITableViewController {
    
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "RecentCell", bundle: nil), forCellReuseIdentifier: "raCell")
        self.tableView.register(UINib(nibName: "RecentCell2", bundle: nil), forCellReuseIdentifier: "raCell2")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
        print("Recents page: viewDidAppear")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.row % 2 == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "raCell", for: indexPath) as! RecentCell
            
            cell.postImg.image = UIImage(named: "watchkit-intro")
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "raCell2", for: indexPath) as! RecentCell
            
            cell.postImg.image = UIImage(named: "watchkit-intro")
            return cell
        
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180.0
    }
  
    
}
