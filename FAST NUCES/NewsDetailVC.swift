//
//  NewsDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 25/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    var newstitle: String!
    var newsImg: String!
    var newsdesc: String!
    var newsdate: Int!
    var newsDetails: String!
    
    @IBOutlet weak var Ntitle: UILabel!
    @IBOutlet weak var NImg: UIImageView!
    @IBOutlet weak var Ndesc: UITextView!
    @IBOutlet weak var Ndate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Ntitle.text = newstitle
        Ndesc.text = newsdesc
        
//            var timeInt = "\(newsdate)"
//            timeInt.remove(at: timeInt.startIndex)
//            let timeIntervel = Int(timeInt)! / 1000
//            let date = Date(timeIntervalSince1970: TimeInterval(timeIntervel))
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd, MMMM yyyy HH:mm:a"
//            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//            let dateString = dateFormatter.string(from: date)
//            Ndate.text = dateString
        
        NImg.sd_setImage(with: URL(string: newsImg), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
    }

    
    @IBAction func detailTapped(_ sender: Any) {
       
    }

    @IBAction func cancelTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecentsVC")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebVC"
        {
            let detailwebVC = segue.destination as? WebDetailVC
            detailwebVC?.detailUrl = newsDetails
        }
    }
    
    
    
    
    

}
