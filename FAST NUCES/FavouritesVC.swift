//
//  FavouritesVC.swift
//  FAST NUCES
//
//  Created by Faizan on 24/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import ProgressHUD
import FirebaseDatabase

let gridWidth : CGFloat = (UIScreen.main.bounds.size.width/2)-5.0
private let reuseIdentifier = "faCell"

class FavouritesVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var parentNavigationController : UINavigationController?
    
    var favs = [Favourites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        collectionView.frame = UIScreen.main.bounds
        collectionView.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
        collectionView.reloadData()

        
        ProgressHUD.show()
        DataService.instance.NEWS_REF.queryOrdered(byChild: "date").observe(.value, with: { (snapshot) in
            
            self.favs = []
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let details = dict["details"] as! String
                        let title = dict["title"] as! String
                        let description = dict["description"] as! String
                        let date = dict["date"] as! Int
                        let imageUrl = dict["imageUrl"] as! String
                        let fav = Favourites(postkey: key ,title: title, description: description, date: date, details: details, imageUrl: imageUrl)
                        self.favs.append(fav)
                    }
                }
            }
            self.collectionView.reloadData()
            ProgressHUD.dismiss()
        })
      
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        
        return favs.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fav = self.favs[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavouritesCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.configureCell(fav: fav)

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize{
    
        if indexPath.row % 2 == 0
        {
            return CGSize(width: gridWidth, height: 200)
            
        }
        else
        {
            return CGSize(width: gridWidth, height: 270)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavDetailVC"
        {
            let cell = sender as! FavouritesCell
            let indexpath = collectionView.indexPath(for: cell)
            let fav = self.favs[(indexpath?.row)!]
            let fvdetailVC = segue.destination as! FavDetailVC
            fvdetailVC.FTitle = fav.title
            fvdetailVC.FDate = fav.date
            fvdetailVC.FImage = fav.imageUrl
            fvdetailVC.postkey = fav.postkey
        }
    }
   
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionat section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(50, 50, 50, 50)
        
    }
    
}


