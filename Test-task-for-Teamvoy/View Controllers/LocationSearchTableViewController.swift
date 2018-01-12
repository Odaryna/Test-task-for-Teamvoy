//
//  LocationSearchTableViewController.swift
//  Test-task-for-Teamvoy
//
//  Created by Odaryna on 1/12/18.
//  Copyright © 2018 Odaryna. All rights reserved.
//

import UIKit
import MapKit

protocol LocationTableViewControllerDelegate: class {
    func showSunDetails(for placemark:MKPlacemark)
}

class LocationSearchTableViewController : UITableViewController {
    
    weak var delegate: LocationTableViewControllerDelegate?
    
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "LocationTableViewCell", bundle: nil), forCellReuseIdentifier: "locationCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        cell.delegate = self
        cell.indexPath = indexPath

        let selectedItem = matchingItems[indexPath.row].placemark
        cell.locationLabel?.text = selectedItem.name
        return cell
    }
}

extension LocationSearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchTableViewController: LocationTableViewCellDelegate {
    func lookAtTheSunDetailsTapped(_ indexPath: IndexPath) {
        
        if let locationDelegate = delegate {
            self.dismiss(animated: true, completion: {
                locationDelegate.showSunDetails(for: self.matchingItems[indexPath.row].placemark)
            })
        }
    }
}
