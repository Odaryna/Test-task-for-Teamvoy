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
    private var currentSunDetails : SunDetails?
    
    @IBAction func showSunDetailsForCurrentLocation(_ sender: UIButton) {
        self.getSunDetails(CGPoint()) { dictionary in
            
            if let json = dictionary["results"] as? [String: Any] {
                if let sunDetails = SunDetails.init(json: json) {
                    
                    self.currentSunDetails = sunDetails
                    self.prepare(for: UIStoryboardSegue.init(identifier: "showSunDetails", source: self, destination: self), sender: self)
                }
            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSunDetails" {
            if let vc = segue.destination as? SunDetailsTableViewController {
                //vc.brandName = self.brandName
            }
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
    
    private func getSunDetails(_ location:CGPoint, completionHandler: @escaping (_ result: NSDictionary) -> Void) -> Void {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        let completeURL = "https://api.sunrise-sunset.org/json"
        
        Alamofire.request(completeURL, method: .get, parameters: ["lat": location.x, "lng": location.y], encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)") // your JSONResponse result
                completionHandler(JSON as! NSDictionary)
            }
            else {
                print(response.result.error!)
            }
        }
    }

}

