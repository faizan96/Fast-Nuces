//
//  RecentDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 11/02/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class RecentDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
