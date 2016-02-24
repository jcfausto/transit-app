//
//  Stop.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

struct Stop {
    var name: String
    var longitude: Double
    var latitude: Double
    var time: NSDate
    
    init(name: String, latitude: Double, longitude: Double, time: NSDate){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.time = time
    }
}
