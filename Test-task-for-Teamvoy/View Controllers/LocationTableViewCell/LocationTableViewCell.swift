//
//  LocationTableViewCell.swift
//  Test-task-for-Teamvoy
//
//  Created by Odaryna on 1/12/18.
//  Copyright © 2018 Odaryna. All rights reserved.
//

import UIKit

protocol LocationTableViewCellDelegate: class {
    func lookAtTheSunDetailsTapped(_ indexPath:IndexPath)
}

class LocationTableViewCell: UITableViewCell {
    
    weak var delegate: LocationTableViewCellDelegate?
    var indexPath : IndexPath? = nil
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBAction func lookAtTheSunDetails(_ sender: UIButton) {
        
        if let locationTableViewDelegate = delegate, let currentIndexPath = indexPath {
            locationTableViewDelegate.lookAtTheSunDetailsTapped(currentIndexPath)
        }
    }
}

