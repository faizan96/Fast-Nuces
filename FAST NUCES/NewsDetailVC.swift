//
//  NewsDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 25/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import Social

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
    
    
    @IBAction func shareTapped(_ sender: Any) {

        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default) { (action) in
            
            // Check if Twitter is available. Otherwise, display an error message
            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
                let alertMessage = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                
                return
            }
            
            // Display Tweet Composer
            if let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                tweetComposer.setInitialText("Having lunch at " + self.newstitle)
                let ImgUrl = NSURL(string: self.newsImg)
                let ImgData = NSData(contentsOf: ImgUrl! as URL)
                let image = UIImage(data: ImgData! as Data)
                tweetComposer.add(image)
                self.present(tweetComposer, animated: true, completion: nil)
            }
        }
        
        let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default) { (action) in
            
            // Check if Facebook is available. Otherwise, display an error message
            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
                let alertMessage = UIAlertController(title: "Facebook Unavailable", message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                
                return
            }
            
            // Display Tweet Composer
            if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                fbComposer.setInitialText("Having lunch at " + self.newstitle)
                let ImgUrl = NSURL(string: self.newsImg)
                let ImgData = NSData(contentsOf: ImgUrl! as URL)
                let image = UIImage(data: ImgData! as Data)
                fbComposer.add(image)
        
                self.present(fbComposer, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(cancelAction)
        
        self.present(shareMenu, animated: true, completion: nil)
        
    }
    
    
    
    
    

}
