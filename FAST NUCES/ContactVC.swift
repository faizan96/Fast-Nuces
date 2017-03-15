//
//  ContactVCViewController.swift
//  FAST NUCES
//
//  Created by Faizan on 11/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MessageUI
import SCLAlertView

let SearchColor = UIColor(red: 217.0/255, green: 56.0/255, blue: 41.0/255, alpha: 1.0)

class ContactVC: UIViewController,UITableViewDataSource,UITableViewDelegate, MFMailComposeViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var inSearchMode = false
    var filteredcontact = [Faculty]()
    
    var contact = [Faculty]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.layer.cornerRadius = 5.0
        self.title = "Contact Your Faculty"
        
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        tap.numberOfTapsRequired = 1
//        view.addGestureRecognizer(tap)
        
        
        DataService.instance.FAC_REF.observe(.value, with: { (snapshot) in
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    
                    if let snapshot = snap.children.allObjects as? [FIRDataSnapshot]
                    {
                        for snap in snapshot
                        {
                    
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        if let name = postDict["Name"] as? String, let profileImg = postDict["LinkedIn"] as? String, let email = postDict["Email"] as? String, let designation = postDict["Designation"] as? String
                        {
                            let teacher = Faculty(name: name, thumbnail: profileImg, email: email, designation: designation)
                            self.contact.append(teacher)
                            
                        }
                    }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        
        
        
       
    }

    
    
    
    
    
    func	tableView(_	tableView:	UITableView,numberOfRowsInSection section:	Int)	->	Int
    {
        if inSearchMode
        {
            return filteredcontact.count
        }
        
        return contact.count
    }
    
    
    func	tableView(_	tableView:	UITableView,	cellForRowAt	indexPath:IndexPath)	->	UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ContactCell {
            
            let fac: Faculty!
            
            if inSearchMode {
                
                fac = filteredcontact[indexPath.row]
                cell.configureCell(faculty: fac)
                
            } else {
                
                fac = contact[indexPath.row]
                cell.configureCell(faculty: fac)
                
            }
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor.clear
            cell.selectedBackgroundView = backgroundView
            
            return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if inSearchMode {
            
            let userEmail = filteredcontact[indexPath.row].email
            let userName = filteredcontact[indexPath.row].name
            showEmail(user: userEmail,name: userName)
            tableView.deselectRow(at: indexPath, animated: true)

        } else {
            
            let userEmail = contact[indexPath.row].email
            let userName = contact[indexPath.row].name
            showEmail(user: userEmail,name: userName)
            tableView.deselectRow(at: indexPath, animated: true)

        }
        
        
    }
    
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
        tableView.layer.cornerRadius = 5.0
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = SearchColor
        
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = SearchColor
        
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = SearchColor
        
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = SearchColor
    }
    
    
    func showEmail(user: String,name: String) {
        
       
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        
        let emailTitle = ""
        let messageBody = "Hello \(name)"
        let toRecipients = [user]
        
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setSubject(emailTitle)
        mailComposer.setMessageBody(messageBody, isHTML: false)
        mailComposer.setToRecipients(toRecipients)
        
        self.navigationController?.present(mailComposer, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            SCLAlertView().showNotice("Mail", subTitle: "Your Email Has Been Cancelled")
        case MFMailComposeResult.saved:
           SCLAlertView().showInfo("Mail", subTitle: "Your Email Has Been Saved")
        case MFMailComposeResult.sent:
            SCLAlertView().showSuccess("Mail", subTitle: "Your Email Has Been Sent")
        case MFMailComposeResult.failed:
            SCLAlertView().showError("Email Failed", subTitle: "Kindly Try again later to send")
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!.capitalized
            
            filteredcontact = contact.filter({$0.name.range(of: lower) != nil})
            tableView.reloadData()
            
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
    }
    
}
