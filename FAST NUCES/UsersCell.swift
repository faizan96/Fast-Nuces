//
//  UsersCell.swift
//  FAST NUCES
//
//  Created by Faizan on 22/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import FirebaseStorage

class UsersCell: UITableViewCell {
    
    var user : Users!

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
        let imageUrl = users.thumbnail
        
            if imageUrl.hasPrefix("gs://")
            {
                FIRStorage.storage().reference(forURL: imageUrl).data(withMaxSize: INT64_MAX, completion: { (data, error) in
                    if let error = error
                    {
                        print("Error Donwloading......\(error.localizedDescription)")
                    }
                    self.userImg.image = UIImage.init(data: data!)
                })
                
                
            }
                
            else if let url = NSURL(string: imageUrl),let data = NSData(contentsOf: url as URL)
            {
                self.userImg.image = UIImage.init(data: data as Data)
            }
        
    }
    
    
}
