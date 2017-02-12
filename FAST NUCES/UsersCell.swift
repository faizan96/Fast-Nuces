//
//  UsersCell.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring



class UsersCell: UITableViewCell {
    
    var user : Users!

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var userImg: DesignableImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImg.layer.cornerRadius = 20
        userImg.layer.masksToBounds = true
    }

    func configureCell(users : Users)
    {
        self.userLbl.text = users.username
        self.emailLbl.text = users.email
        let imageUrl = users.thumbnail
         userImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "profileImage"), options: [.continueInBackground,.progressiveDownload])

        
    }
    

    
}
