//
//  RecentsVC.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class RecentsVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var parentNavigationController : UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.showsVerticalScrollIndicator = false
        super.viewDidAppear(animated)
        self.tableView.showsVerticalScrollIndicator = true
        
        print("Recents page: viewDidAppear")
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FavouritesCell
    
      
        cell.postImg.image = UIImage(named: "watchkit-intro")
        
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
}
