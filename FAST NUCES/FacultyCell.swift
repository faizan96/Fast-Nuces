//
//  FacultyCell.swift
//  FAST NUCES
//
//  Created by Faizan on 11/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit

class FacultyCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var designationLbl : UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(faculty : Faculty)
    {
        self.designationLbl.text = faculty.designation
        self.emailLbl.text = faculty.email
        self.titleLbl.text = faculty.name
        let imageUrl = faculty.thumbnail
        
        profileImg.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "profileImage"), options: [.continueInBackground,.progressiveDownload])
    }

}
