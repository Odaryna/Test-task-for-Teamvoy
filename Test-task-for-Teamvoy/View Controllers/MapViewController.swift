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

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var resultSearchController:UISearchController? = nil
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var currentSunDetails : SunDetails?
    private var currentPlacemark: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 100, 100)
                mapView.setRegion(viewRegion, animated: false)
            }
        }
    }
    
    @IBAction func showSunDetailsForCurrentLocation(_ sender: UIButton) {
        
        currentPlacemark = "current location"
        self.getSunDetails((currentLocation?.coordinate)!) { dictionary in
            
            if let json = dictionary["results"] as? [String: Any] {
                if let sunDetails = SunDetails.init(json: json) {
                    
                    self.currentSunDetails = sunDetails
                    self.performSegue(withIdentifier: "showSunDetails", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSunDetails" {
            if let vc = segue.destination as? SunDetailsTableViewController {
                vc.sunDetails = self.currentSunDetails
                vc.placeTitle = self.currentPlacemark
            }
        }
    }
    
    private func getSunDetails(_ location:CLLocationCoordinate2D, completionHandler: @escaping (_ result: NSDictionary) -> Void) -> Void {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type" :"application/json"
        ]
        
        let completeURL = "https://api.sunrise-sunset.org/json"
        
        let parameters: [String : Double] = [
            "lat": location.latitude + 0.000000001,
            "lng": location.longitude + 0.000000001
        ]
        
        Alamofire.request(completeURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
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

extension MapViewController : LocationTableViewControllerDelegate {
    func showSunDetails(for placemark: MKPlacemark) {
        
        self.resultSearchController?.resignFirstResponder()
        currentPlacemark = placemark.name
        self.getSunDetails(placemark.coordinate, completionHandler: { (dictionary) in
            
            if let json = dictionary["results"] as? [String: Any] {
                if let sunDetails = SunDetails.init(json: json) {
                    
                    self.currentSunDetails = sunDetails
                    self.performSegue(withIdentifier: "showSunDetails", sender: self)
                }
            }
        })
    }
}

