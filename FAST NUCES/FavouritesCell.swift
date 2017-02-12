//
//  FavouritesCell.swift
//  FAST NUCES
//
//  Created by Faizan on 24/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class FavouritesCell: UICollectionViewCell {

    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(fav : Favourites)
    {
        self.titleLbl.text = fav.title
        let imageUrl = fav.imageUrl
        
        postImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
    }
    

}
