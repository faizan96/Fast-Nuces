//
//  Contact.swift
//  FAST NUCES
//
//  Created by Faizan on 11/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(faculty : Faculty)
    {
       
        self.emailLbl.text = faculty.email
        self.titleLbl.text = faculty.name
        
    }

    
}
