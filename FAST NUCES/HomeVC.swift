//
//  HomeVC.swift
//  FAST NUCES
//
//  Created by Faizan on 07/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
let firstColor = UIColor(red: 44.0/255, green: 79.0/255, blue: 86.0/255, alpha: 0.4)
let secondColor = UIColor(red: 39.0/255, green: 145.0/255, blue: 111.0/255, alpha: 0.4)
let thirdColor = UIColor(red: 194.0/255, green: 65.0/255, blue: 0.0/255, alpha: 0.4)
let fourhtCOlor = UIColor(red: 39.0/255, green: 105.0/255, blue: 176.0/255, alpha: 0.4)
let fifthColor = UIColor(red: 122.0/255, green: 95.0/255, blue: 73.0/255, alpha: 0.4)
let sixthColor = UIColor(red: 194.0/255, green: 65.0/255, blue: 0.0/255, alpha: 0.4)

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    let colorArr = [firstColor,secondColor,thirdColor,fourhtCOlor,fifthColor,sixthColor]
    let titleArr = ["Newsfeed","Recent Event","Our Faculty","Contact Your Teacher","Upcoming Fast Event","Student Socities"]
    let imgArr = ["newsfeed","calendar","university-building","email","check-form","user"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.clear

        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? HomeCell
        cell?.backgroundColor = colorArr[indexPath.row]
        cell?.titleLbl.text = titleArr[indexPath.row]
        cell?.ImgLbl.image = UIImage(named: imgArr[indexPath.row])
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        if indexPath.row % 5 == 0
        {
            
            let deviceSize = UIScreen.main.bounds.size
            let cellWidth = ((deviceSize.width))
            
            return CGSize(width: cellWidth , height: 160)
        }
        else
        {
            let deviceSize = UIScreen.main.bounds.size
            let cellWidth = ((deviceSize.width / 2))
            let cellHeight = (deviceSize.height / 3)
            
            return CGSize(width: cellWidth , height: cellHeight)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            performSegue(withIdentifier: "GoNews", sender: nil)
        }
        if indexPath.row == 1
        {
            performSegue(withIdentifier: "GoRecent", sender: nil)
        }
        if indexPath.row == 2
        {
            performSegue(withIdentifier: "GoFaculty", sender: nil)
        }
        if indexPath.row == 3
        {
            performSegue(withIdentifier: "GoContact", sender: nil)
        }
        if indexPath.row == 5
        {
            performSegue(withIdentifier: "GoSociety", sender: nil)
        }
    }
    
    

}
