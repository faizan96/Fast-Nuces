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
        let ImgUrl = NSURL(string: imageUrl)
        DispatchQueue.global(qos: .background).async {
            let ImgData = NSData(contentsOf: ImgUrl! as URL)
            let image = UIImage(data: ImgData! as Data);
            
            DispatchQueue.main.async {
                self.userImg.image = image
            }
        }


        
    }
    

    
}
