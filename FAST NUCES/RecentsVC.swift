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

class RecentsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,iCarouselDelegate,iCarouselDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var parentNavigationController : UINavigationController?
    @IBOutlet weak var carousal: iCarousel!
    @IBOutlet weak var catImg: UIImageView!
    
    var sliderCount = 0
    
    var recents = [Recent]()
    var carousals = [Carousal]()
    
    override func viewDidLoad() {
        sliderCount = 0
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.runMethod), userInfo: nil, repeats: true)
       
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
        
        DataService.instance.NEWS_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            
            self.carousals = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        let title = dict["title"] as! String
                        let imageUrl = dict["imageUrl"] as! String
                        let carousal = Carousal(title: title, imageUrl: imageUrl)
                        self.carousals.append(carousal)
                    }
                }
            }
           self.carousal.reloadData()
        })
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
    }
    
    func runMethod() {
        self.carousal.scrollToItem(at: sliderCount, animated: true)
        if sliderCount == carousals.count {
            sliderCount = 0
        }
        else {
            sliderCount += 1
        }
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
    
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return carousals.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView: UIImageView
        let label : UILabel
        
        if view == nil
        {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: carousel.bounds.size.width, height: 120))
            imageView.clipsToBounds = true
            imageView.contentMode = UIViewContentMode.scaleToFill
            let url = carousals[index].imageUrl
            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
            
            label = UILabel(frame: imageView.bounds)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.sizeToFit()
            label.frame = CGRect(x: 0, y: 70, width: carousel.bounds.size.width, height: 50)
            label.textColor = UIColor.white
            label.font = UIFont(name: "Proxima Nova Alt Regular", size: 19.0)
            label.tag = 1
            
            
            imageView.addSubview(label)
        }
        else
        {
            imageView = view as! UIImageView
            label = imageView.viewWithTag(1) as! UILabel!
        }
        
        label.text = carousals[index].title
        return imageView
       
        
       
    }
    
    
    
    
}
