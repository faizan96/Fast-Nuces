//
//  MapDetailVC.swift
//  FAST NUCES
//
//  Created by Faizan on 13/03/2017.
//  Copyright © 2017 Faizan. All rights reserved.
//

import UIKit
import MapKit

class MapDetailVC: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        
        if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            mapView.showsUserLocation = true
        }
        
        let location = CLLocation(latitude: 24.8569, longitude: 67.2647)
        let annotation = MKPointAnnotation()
        annotation.title = "Fast University"
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
        self.mapView.setRegion(region, animated: true)
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: "FAST-NU_Karachi")
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.red
        
        return annotationView
    }
   
}
