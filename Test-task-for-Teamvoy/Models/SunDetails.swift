//
//  SunsetSunriseTimes.swift
//  Test-task-for-Teamvoy
//
//  Created by Odaryna on 1/10/18.
//  Copyright © 2018 Odaryna. All rights reserved.
//

import Foundation

struct SunDetails {
    
    let sunriseDate: String
    let sunsetDate: String
    let solarNoonDate: String
    let dayLengthDate: String
    let civilTwilightBeginDate: String
    let civilTwilightEndDate: String
    let nauticalTwilightBeginDate: String
    let nauticalTwilightEndDate: String
    let astronomicalTwilightBeginDate: String
    let astronomicalTwilightEndDate: String
}


extension SunDetails {
    init?(json: [String: Any]) {
        guard let sunrise = json["sunrise"] as? String,
            let sunset = json["sunset"] as? String,
        let solarNoon = json["solar_noon"] as? String,
        let dayLength = json["day_length"] as? String,
        let civilTwilightBegin = json["civil_twilight_begin"] as? String,
        let civilTwilightEnd = json["civil_twilight_end"] as? String,
        let nauticalTwilightBegin = json["nautical_twilight_begin"] as? String,
        let nauticalTwilightEnd = json["nautical_twilight_end"] as? String,
        let astronomicalTwilightBegin = json["astronomical_twilight_begin"] as? String,
        let astronomicalTwilightEnd = json["astronomical_twilight_end"] as? String
            else {
                return nil
        }
        
        self.sunriseDate = DateFormatter().getLocalTime(from: sunrise)
        self.sunsetDate = DateFormatter().getLocalTime(from: sunset)
        self.solarNoonDate = DateFormatter().getLocalTime(from: solarNoon)
        self.dayLengthDate = dayLength
        self.civilTwilightBeginDate = DateFormatter().getLocalTime(from: civilTwilightBegin)
        self.civilTwilightEndDate = DateFormatter().getLocalTime(from: civilTwilightEnd)
        self.nauticalTwilightBeginDate = DateFormatter().getLocalTime(from: nauticalTwilightBegin)
        self.nauticalTwilightEndDate = DateFormatter().getLocalTime(from: nauticalTwilightEnd)
        self.astronomicalTwilightBeginDate = DateFormatter().getLocalTime(from: astronomicalTwilightBegin)
        self.astronomicalTwilightEndDate = DateFormatter().getLocalTime(from: astronomicalTwilightEnd)

    }
}

extension DateFormatter {
    func getLocalTime(from utcTime:String) -> String {

        self.dateFormat = "hh:mm:ss a"
        self.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let date = self.date(from: utcTime)
        
        self.timeZone = NSTimeZone.local
        let timeStamp = self.string(from: date!)
        
        return timeStamp
    }
}
