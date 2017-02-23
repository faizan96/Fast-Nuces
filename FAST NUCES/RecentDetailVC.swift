//
//  RecentDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring

class RecentDetailVC: UIViewController {
    
    var postkey: String!
    var RImage: String!
    var RTitle: String!
    var RDesc: String!
    var RStars: Int!
    
    
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var recenttitle: UILabel!
    @IBOutlet weak var starLbl: UILabel!
    @IBOutlet weak var postImg: DesignableImageView!
    @IBOutlet weak var starButton: FaveButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
          print(postkey)

        caption.text = RDesc
        recenttitle.text = RTitle
        
        postImg.sd_setImage(with: URL(string: RImage), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
    }

    

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool){
        print("faizan")
        
    }
    
    
    
    
    
    
}
