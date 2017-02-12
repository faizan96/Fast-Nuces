//
//  RecentsVC.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseDatabase

class RecentsVC: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var parentNavigationController : UINavigationController?
    
    var recents = [Recent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ProgressHUD.show()
        DataService.instance.NEWS_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            
            self.recents = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let details = dict["details"] as! String
                        let title = dict["title"] as! String
                        let description = dict["description"] as! String
                        let date = dict["date"] as! Int
                        let imageUrl = dict["imageUrl"] as! String
                        let recents = Recent(postkey: "" ,title: title, description: description, date: date, details: details, imageUrl: imageUrl)
                        self.recents.append(recents)
                    }
                }
            }
            self.tableView.reloadData()
            ProgressHUD.dismiss()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
        print("Recents page: viewDidAppear")
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let recent = self.recents[indexPath.row]
        
        if indexPath.row % 2 == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "raCell", for: indexPath) as! RecentCell
            
            cell.configureCell(recent: recent)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "raCell2", for: indexPath) as! RecentCell
            cell.configureCell(recent: recent)
            return cell
        
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
}
