//
//  RecentDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import Social

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil) 

        caption.text = RDesc
        recenttitle.text = RTitle
      
        postImg.sd_setImage(with: URL(string: RImage), placeholderImage: UIImage(named: "preview"), options: [.continueInBackground,.progressiveDownload])
        
    }

    

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatVC"
        {
            let chatVC = segue.destination as? ChatVC
            chatVC?.postid = postkey
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
                tweetComposer.setInitialText("Having lunch at " + self.RTitle)
                let ImgUrl = NSURL(string: self.RImage)
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
                fbComposer.setInitialText("Having lunch at " + self.RTitle)
                let ImgUrl = NSURL(string: self.RImage)
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
