//
//  SocietyCell.swift
//  FAST NUCES
//
//  Created by Faizan on 14/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class SocietyCell: UICollectionViewCell {
    
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    func configureCell(soc : Society)
    {
        self.titleLbl.text = soc.title
        let imageUrl = soc.imageUrl
        
        thumbnail.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
    }
    
    
}
