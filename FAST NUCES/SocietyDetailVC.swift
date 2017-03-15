//
//  SocietyDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 14/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class SocietyDetailVC: UIViewController {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var descLbl: UITextView!
    
    var Stitle: String!
    var Sdesc: String!
    var SImg: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = Stitle
        self.descLbl.text = Sdesc
        
          thumbnail.sd_setImage(with: URL(string: SImg), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
    }

    

}
