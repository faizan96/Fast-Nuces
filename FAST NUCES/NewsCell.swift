//
//  NewsCell.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(news : News)
    {
        self.titleLbl.text = news.title
        let imageUrl = news.imageUrl
        
        postImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
    }

}
