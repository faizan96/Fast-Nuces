//
//  RecentCell.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class RecentCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(recent : Recent)
    {
        self.titleLbl.text = recent.title
        let imageUrl = recent.imageUrl
        
        postImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
    }
    
}
