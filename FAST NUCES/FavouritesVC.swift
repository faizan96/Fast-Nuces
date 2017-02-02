//
//  FavouritesVC.swift
//  FAST NUCES
//
//  Created by Faizan on 24/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import TRMosaicLayout


private let reuseIdentifier = "faCell"

class FavouritesVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var parentNavigationController : UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
      
      
    }


     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
     {
        
        return 9
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavouritesCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.postImg.image = UIImage(named: "watchkit-intro")

        
        return cell
    }
   
    
}


extension FavouritesVC: TRMosaicLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
        
        return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        return 150
    }
}
