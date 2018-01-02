//
//  ViewController.swift
//  Test-task-for-Teamvoy
//
//  Created by Odaryna on 1/1/18.
//  Copyright © 2018 Odaryna. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    @IBAction func showSunDetailsForCurrentLocation(_ sender: UIButton) {
        
        Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                // response handling code
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 200, 200)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }

}

