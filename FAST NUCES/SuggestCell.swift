//
//  SuggestCell.swift
//  FAST NUCES
//
//  Created by Faizan on 14/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import Spring
import SCLAlertView

class SuggestCell: UITableViewCell {
    
    @IBOutlet weak var suggestField: UITextView!
    @IBOutlet weak var emailField: DesignableTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func sentTapped(_ sender: Any) {
        
       if let suggestion =  suggestField.text , !suggestion.isEmpty
        {
             SCLAlertView().showSuccess("Suggestion Sent", subTitle: "Thank You, we will act upon Your suggestion on next Update")
        }
        else
        {
             SCLAlertView().showNotice("Suggestion Field Required", subTitle: "To response, You should enter the Suggestion field")
        }
        
    }

}
