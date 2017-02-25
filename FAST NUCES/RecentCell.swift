//
//  RecentCell.swift
//  FAST NUCES
//
//  Created by Faizan on 23/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import AVFoundation
import FirebaseAuth

let myColor = UIColor(red: 100.0, green: 67.0, blue: 20.0, alpha: 1.0)

class RecentCell: UITableViewCell {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var sratLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var starBtn: FaveButton!
    
    var starsRef: FIRDatabaseReference!
    var recent : Recent!
    var music : AVAudioPlayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
               self.starBtn.isSelected = false
            } else {
               self.starBtn.isSelected = true
              
            }
        })
    }
    
    func initAudio()
    {
        let path = Bundle.main.path(forResource: "click", ofType: "wav")
        
        
        do{
            music  = try AVAudioPlayer(contentsOf: URL(string: path!)!)
            music.prepareToPlay()
            music.play()
        }
        catch let err as NSError
        {
            print(err.debugDescription)
        }
    }
    
    @IBAction func starTapped(_ sender: Any) {
       
        starsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.recent.adjustLikes(addLike: true)
                self.starsRef.setValue(true)
            } else {
                self.recent.adjustLikes(addLike: false)
                self.starsRef.removeValue()
            }
        })

    }
    
    @IBAction func commentTapped(_ sender: Any) {
       print("Faizan naseem")
    }
    
    
}
