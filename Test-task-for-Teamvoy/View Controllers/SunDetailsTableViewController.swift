//
//  SunsetSunriseTimesTVC.swift
//  Test-task-for-Teamvoy
//
//  Created by Odaryna on 1/9/18.
//  Copyright © 2018 Odaryna. All rights reserved.
//

import UIKit

class SunDetailsTableViewController: UITableViewController {
    
    var sunDetails : SunDetails!
    var placeTitle: String? = nil
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var solarMoonLabel: UILabel!
    @IBOutlet weak var dayLength: UILabel!
    @IBOutlet weak var civilTwilightBegin: UILabel!
    @IBOutlet weak var civilTwilightEnd: UILabel!
    @IBOutlet weak var nauticalTwilightBegin: UILabel!
    @IBOutlet weak var nauticalTwilightEnd: UILabel!
    @IBOutlet weak var astronomicalTwilightBegin: UILabel!
    @IBOutlet weak var astronomicalTwilightEnd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sunriseLabel.text = self.sunDetails.sunriseDate
        self.sunsetLabel.text = self.sunDetails.sunsetDate
        self.solarMoonLabel.text = self.sunDetails.solarNoonDate
        self.dayLength.text = self.sunDetails.dayLengthDate
        self.civilTwilightBegin.text = self.sunDetails.civilTwilightBeginDate
        self.civilTwilightEnd.text = self.sunDetails.civilTwilightEndDate
        self.nauticalTwilightBegin.text = self.sunDetails.nauticalTwilightBeginDate
        self.nauticalTwilightEnd.text = self.sunDetails.nauticalTwilightEndDate
        self.astronomicalTwilightBegin.text = self.sunDetails.astronomicalTwilightBeginDate
        self.astronomicalTwilightEnd.text = self.sunDetails.astronomicalTwilightEndDate
    
        if self.placeTitle != nil {
            self.title = "Sun Details for \(placeTitle!)"
        }
    }


}
