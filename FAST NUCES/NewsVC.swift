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
import ProgressHUD
import ReachabilitySwift
import SCLAlertView
import GoogleMobileAds


class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var news = [News]()
    
    var reachability: Reachability?
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        request.testDevices = [ "0b28d9ebfd04b2a330f86603fafb690a" ]
        bannerView?.adUnitID = "ca-app-pub-5765623355505954/8482691426"
        bannerView?.rootViewController = self
        bannerView?.load(request)
        
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))

            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
       
        observeData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupReachability(nil, useClosures: true)
        startNotifier()
    }
    
    
    
    func observeData()
    {
        ProgressHUD.show()
        DataService.instance.NEWS_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            
            self.news = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let details = dict["details"] as! String
                        let title = dict["title"] as! String
                        let description = dict["description"] as! String
                        let date = dict["date"] as! Int
                        let imageUrl = dict["imageUrl"] as! String
                        let news = News(postkey: "" ,title: title, description: description, date: date, details: details, imageUrl: imageUrl)
                        self.news.append(news)
                    }
                }
            }
            ProgressHUD.dismiss()
            self.tableView.reloadData()
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = self.news[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.configureCell(news: news)
        
        return cell
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewsDetailVC"
        {
            let cell = sender as! NewsCell
            let indexpath = tableView.indexPath(for: cell)
            let news = self.news[(indexpath?.row)!]
            let newsdetailVC = segue.destination as! NewsDetailVC
            newsdetailVC.newstitle = news.title
            newsdetailVC.newsdesc = news.description
            newsdetailVC.newsImg = news.imageUrl
            newsdetailVC.newsDetails = news.details
            newsdetailVC.newsdate = news.date
            
        }
    }
    
    
    func setupReachability(_ hostName: String?, useClosures: Bool) {
        
        
        let reachability = hostName == nil ? Reachability() : Reachability(hostname: hostName!)
        self.reachability = reachability
        
        if useClosures {
            reachability?.whenReachable = { reachability in
                DispatchQueue.main.async {
                    
                }
            }
            reachability?.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    self.updateNotReachable(reachability)
                }
            }
        }
    }
    
    func startNotifier() {
        print("--- start notifier")
        do {
            try reachability?.startNotifier()
        } catch {
            
            return
        }
    }
    
    func updateNotReachable(_ reachability: Reachability) {
        print("\(reachability.description) - \(reachability.currentReachabilityString)")
        ProgressHUD.dismiss()
        SCLAlertView().showWarning("Connection", subTitle: "You are out of Internet Connection")
    }
    

    
   

    
    
}
