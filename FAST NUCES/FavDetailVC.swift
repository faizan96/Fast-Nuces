//
//  FavDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.  FavDetailVC
//

import UIKit


class FavDetailVC: UIViewController {
    
    var postkey: String!
    var FImage: String!
    var FTitle: String!
    var FDate: Int!
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(postkey)
        
        postTitle.text = FTitle
         postImg.sd_setImage(with: URL(string: FImage), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
    }


    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    

}
