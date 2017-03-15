//
//  FacultyVC.swift
//  FAST NUCES
//
//  Created by Faizan on 11/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import FirebaseDatabase


class FacultyVC: UIViewController,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var sectionTitles = ["Department of Computer Science", "Department of Electrical Engineering","Department of Sciences & Humanities"]
    var sectionCS = [Faculty]()
    var sectionEE = [Faculty]()
    var sectionSS = [Faculty]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Faculty"
        self.tableView.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 235.0/255, alpha: 1.0)
        
        
            
        DataService.instance.FAC_REF.child("cs").observe(.value, with: { (snapshot) in
            
           
                 if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
                 {
                        for snap in snapshot
                        {
                            if let postDict = snap.value as? Dictionary<String, AnyObject>
                            {
                             if let name = postDict["Name"] as? String, let profileImg = postDict["LinkedIn"] as? String, let email = postDict["Email"] as? String, let designation = postDict["Designation"] as? String
                                {
                                    let teacher = Faculty(name: name, thumbnail: profileImg, email: email, designation: designation)
                                   self.sectionCS.append(teacher)
                                  
                                }
                            }
                        }
                }
        
             self.tableView.reloadData()
        })
        
        DataService.instance.FAC_REF.child("ee").observe(.value, with: { (snapshot) in
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        if let name = postDict["Name"] as? String, let profileImg = postDict["LinkedIn"] as? String, let email = postDict["Email"] as? String, let designation = postDict["Designation"] as? String
                        {
                            let teacher = Faculty(name: name, thumbnail: profileImg, email: email, designation: designation)
                            self.sectionEE.append(teacher)
                            
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        
        DataService.instance.FAC_REF.child("ss").observe(.value, with: { (snapshot) in
            
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                for snap in snapshot
                {
                    if let postDict = snap.value as? Dictionary<String, AnyObject>
                    {
                        if let name = postDict["Name"] as? String, let profileImg = postDict["LinkedIn"] as? String, let email = postDict["Email"] as? String, let designation = postDict["Designation"] as? String
                        {
                            let teacher = Faculty(name: name, thumbnail: profileImg, email: email, designation: designation)
                            self.sectionSS.append(teacher)
                            
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
        })
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView? = (view as? UITableViewHeaderFooterView)
        header?.textLabel?.textColor = UIColor.black
        header?.textLabel?.font = UIFont(name: "AvenirNext-Bold", size: 15.5)
        let headerFrame: CGRect? = header?.frame
        header?.textLabel?.frame = headerFrame!
        header?.textLabel?.textAlignment = .left
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0
        {
            return sectionCS.count
        }
        if section == 1
        {
            return sectionEE.count
        }
        if section == 2
        {
            return sectionSS.count
        }
        
        return Int()
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
            
        case 0:
                    let faculty = sectionCS[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FacultyCell
                    cell?.configureCell(faculty: faculty)
                    return cell!
            
        case 1:
                    let faculty = sectionEE[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FacultyCell
                    cell?.configureCell(faculty: faculty)
                return cell!
        case 2:
                    let faculty = sectionSS[indexPath.row]
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FacultyCell
                    cell?.configureCell(faculty: faculty)
                    return cell!
            
            
        default:
            break
        }
        
        
        return UITableViewCell()
        
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }

}
