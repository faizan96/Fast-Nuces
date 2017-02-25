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
        DataService.instance.RECENT_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            
            self.recents = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {

                        if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let recent = Recent(postKey: key, postData: postDict)
                        self.recents.append(recent)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "raCell", for: indexPath) as! RecentCell
        cell.configureCell(recent: recent)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecentDetailVC"
        {
            let cell = sender as! RecentCell
            let indexpath = tableView.indexPath(for: cell)
            let recent = self.recents[(indexpath?.row)!]
            let detailVC = segue.destination as! UINavigationController
            let recentdetailVC = detailVC.topViewController as! RecentDetailVC
            recentdetailVC.RTitle = recent.title
            recentdetailVC.RDesc = recent.description
            recentdetailVC.RImage = recent.imageUrl
            recentdetailVC.postkey = recent.postkey
            recentdetailVC.RStars = recent.star
        }
        
    }
    
}
