//
//  NewsDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 25/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecentsVC")
        self.present(vc, animated: true, completion: nil)
    }

}
