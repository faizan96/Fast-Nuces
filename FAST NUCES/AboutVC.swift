//
//  CreditsVC.swift
//  FAST NUCES
//
//  Created by Faizan on 30/01/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import SafariServices

class AboutVC: UITableViewController {
    

    var sectionTitles = ["About", "Follow Us","Credits","Developer"]
    var sectionContent = [["This app has a credit which goes to Fast University Karachi. This app will update students about the events and competitions collaborating with Fast Photographers Club and Fast Event Updates."],["Website","Facebook"],["Icons use in App By Freepik"],["Facebook","LinkedIn"]]
    var links = ["http://khi.nu.edu.pk/", "https://www.facebook.com/groups/567119140160307/"]
    var links3 = ["http://www.flaticon.com/authors/freepik"]
    var links4 = ["https://www.facebook.com/faizannasimansari", "https://www.linkedin.com/in/faizan-naseem-945a14139/"]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        tableView.tableFooterView	=	UIView(frame:	CGRect.zero)
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text	=	sectionContent[indexPath.section][indexPath.row]
        return	cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        
        case 1:
            if let url = URL(string: links[indexPath.row]) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
            
        case 2:
            if let url = URL(string: links3[indexPath.row]) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
        case 3:
            if let url = URL(string: links4[indexPath.row]) {
                let safariController = SFSafariViewController(url: url)
                present(safariController, animated: true, completion: nil)
            }
   
            
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    

}
