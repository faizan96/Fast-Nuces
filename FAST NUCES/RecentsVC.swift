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
    @IBOutlet weak var catImg: UIImageView!
    
    var sliderCount = 0
    
    var recents = [Recent]()
    
    override func viewDidLoad() {
   //     sliderCount = 0
        super.viewDidLoad()
        
        
        self.title = "Recent Events"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
//        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.runMethod), userInfo: nil, repeats: true)
       
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
        
//        DataService.instance.NEWS_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
//            
//            self.carousals = []
//            
//            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
//                for snap in snapshot {
//                    
//                    if let dict = snap.value as? Dictionary<String, AnyObject> {
//                        let title = dict["title"] as! String
//                        let imageUrl = dict["imageUrl"] as! String
//                        let carousal = Carousal(title: title, imageUrl: imageUrl)
//                        self.carousals.append(carousal)
//                    }
//                }
//            }
//           self.carousal.reloadData()
//        })
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
    }
    
//    func runMethod() {
//        self.carousal.scrollToItem(at: sliderCount, animated: true)
//        if sliderCount == carousals.count {
//            sliderCount = 0
//        }
//        else {
//            sliderCount += 1
//        }
//    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let recent = self.recents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "raCell", for: indexPath) as! RecentCell
        cell.configureCell(recent: recent)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecentDetailVC"
        {
            let cell = sender as! RecentCell
            let indexpath = tableView.indexPath(for: cell)
            let recent = self.recents[(indexpath?.row)!]
            let recentdetailVC = segue.destination as! RecentDetailVC
            recentdetailVC.RTitle = recent.title
            recentdetailVC.RDesc = recent.description
            recentdetailVC.RImage = recent.imageUrl
            recentdetailVC.postkey = recent.postkey
            recentdetailVC.RStars = recent.star
        }
        
    }
    
    

    
    
}
