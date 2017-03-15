//
//  SocietyVC.swift
//  FAST NUCES
//
//  Created by Faizan on 14/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SocietyVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var society = [Society]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Student Socities"
        
         navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        DataService.instance.SOC_REF.observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                print(snapshot)
                for snap in snapshot
                {
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        if let title = postDict["title"] as? String, let imageUrl = postDict["imageUrl"] as? String, let desc = postDict["description"] as? String
                        {
                            let soc = Society(postDesc: desc, title: title, imageUrl: imageUrl)
                            self.society.append(soc)
                        }
                    }
                }
            }
            self.collectionView.reloadData()
        })
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return society.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let society = self.society[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? SocietyCell
        cell?.configureCell(soc: society)
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionat section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 0, 5, 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        
        let deviceSize = UIScreen.main.bounds.size
        let cellWidth = ((deviceSize.width / 2) - 5)
        let cellHeight = (deviceSize.height / 2 - 40)
        
        return CGSize(width: cellWidth , height: cellHeight)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoDetail"
        {
            let cell = sender as! SocietyCell
            let indexpath = collectionView.indexPath(for: cell)
            let soc = self.society[(indexpath?.row)!]
            let detailVC = segue.destination as! SocietyDetailVC
            detailVC.Stitle = soc.title
            detailVC.Sdesc = soc.postDesc
            detailVC.SImg = soc.imageUrl
            
        }
    }
    
    
}
