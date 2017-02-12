//
//  WebDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 08/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import WebKit

class WebDetailVC: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    var detailUrl : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        let url = NSURL(string: detailUrl)
        webView.loadRequest(NSURLRequest(url: url as! URL) as URLRequest)
    }

    
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activityInd.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityInd.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.activityInd.stopAnimating()
    }
    
    

}
