//
//  Stop.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

struct Stop: Unboxable {
    var name: String?
    var longitude: Double
    var latitude: Double
    var time: NSDate
    
    init(name: String, latitude: Double, longitude: Double, time: NSDate){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.time = time
    }
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.latitude = unboxer.unbox("lat")
        self.longitude = unboxer.unbox("lng")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        self.time = unboxer.unbox("datetime", formatter: DateFormatter.sharedInstance.formatterForJsonConversion)
    }
}