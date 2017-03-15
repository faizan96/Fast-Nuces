//
//  LocationDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 13/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "FAST KARACHI"
        
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGesture)
        
        let location = CLLocation(latitude: 24.8569, longitude: 67.2647)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
        
        
    }
    
    func showMap()
    {
        performSegue(withIdentifier: "GoMap", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    
}
