//
//  CreditsVC.swift
//  FAST NUCES
//
//  Created by Faizan on 30/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import SafariServices

class CreditsVC: UITableViewController {
    

    var sectionTitles = ["Leave Feedback", "Follow Us"]
    var sectionContent = [["Rate us on The App Store", "Tell us your feedback"],["Twitter","Facebook","Pintrest"]]
    var links = ["https://twitter.com/appcodamobile", "https://facebook.com/appcodamobile", "https://www.pinterest.com/appcoda/"]
    var links2 = ["https://twitter.com/faizannaseem96","https://twitter.com/faizannaseem96"]
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tableView.tableFooterView	=	UIView(frame:	CGRect.zero)
        
        
    }

   

    override	func	numberOfSections(in	tableView:	UITableView)	->	Int	{
        return	sectionTitles.count
    }
    override	func	tableView(_	tableView:	UITableView,	numberOfRowsInSection
        section:	Int)	->	Int	{
        return	sectionContent[section].count
    }

    override	func	tableView(_	tableView:	UITableView,	titleForHeaderInSection
        section:	Int)	->	String?	{
        return	sectionTitles[section]
    }
    
    override	func	tableView(_	tableView:	UITableView,	cellForRowAt	indexPath:
        IndexPath)	->	UITableViewCell	{
        let	cell	=	tableView.dequeueReusableCell(withIdentifier:	"Cell",	for:
            indexPath)
        
        cell.textLabel?.text	=	sectionContent[indexPath.section][indexPath.row]
        return	cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        
        case 0:
            if let url = URL(string: links2[indexPath.row]) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
            
        
        case 1:
            if let url = URL(string: links[indexPath.row]) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    


}
