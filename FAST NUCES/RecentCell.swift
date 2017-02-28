//
//  RecentCell.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth



class RecentCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var sratLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var starImg: UIImageView!
    
    
    var starsRef: FIRDatabaseReference!
    var recent : Recent!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(starTapped))
        tap.numberOfTapsRequired = 1
        starImg.addGestureRecognizer(tap)
        starImg.isUserInteractionEnabled = true
       
    }
    
  
    func configureCell(recent : Recent)
    {
        let currentUser = FIRAuth.auth()?.currentUser?.uid
        starsRef = AuthService.instance.USERS_REF?.child(currentUser!).child("stars").child(recent.postkey)
        self.recent = recent
        self.titleLbl.text = recent.title
        let imageUrl = recent.imageUrl
        self.descLbl.text = recent.description
        self.sratLbl.text = "\(recent.star)"
        self.commentLbl.text = "\(recent.comment)"
        postImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
        
        starsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
            //   self.starBtn.isSelected = false
               self.starImg.image = UIImage(named: "star2")
            } else {
             //  self.starBtn.isSelected = true
                 self.starImg.image = UIImage(named: "star")
              
            }
        })
    }
    
  
    
     func starTapped(sender: UITapGestureRecognizer) {
       
        starsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.starImg.image = UIImage(named: "star")
                self.recent.adjustLikes(addLike: true)
                self.starsRef.setValue(true)
            } else {
                self.starImg.image = UIImage(named: "star2")
                self.recent.adjustLikes(addLike: false)
                self.starsRef.removeValue()
            }
        })
        Sound.play(file: "click.wav")

    }
    
    
    
    
}
