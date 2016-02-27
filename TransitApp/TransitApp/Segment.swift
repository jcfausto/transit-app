//
//  Segment.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import UIKit
import Unbox

struct Segment {
    var name: String?
    var numStops: Int
    var description: String?
    var stops: [Stop]
    var travelMode: String
    var color: UIColor
    var iconUrl: String
    var polyline: String
    
    init(name: String, numStops: Int, description: String, stops: [Stop],
        travelMode: String, color: UIColor, iconUrl: String, polyline: String)
    {
        self.name = name
        self.numStops = numStops
        self.description = description
        self.stops = stops
        self.travelMode = travelMode
        self.color = color
        self.iconUrl = iconUrl
        self.polyline = polyline
    }

}

// MARK: extensions

extension Segment: Unboxable {
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.numStops = unboxer.unbox("num_stops")
        self.description = unboxer.unbox("description")
        self.stops = unboxer.unbox("stops")
        self.travelMode = unboxer.unbox("travel_mode")
        self.color = UIColor(hexString: unboxer.unbox("color"))
        self.iconUrl = unboxer.unbox("icon_url")
        self.polyline = unboxer.unbox("polyline")
    }
}

// MARK: segment's helper functions

extension Segment {
    
    /**
     Verifies if the segment is a segment where its stops are equal.
     This means that this is a segmente where the person will be stopped
     doing something like a car setup, bike picking, etc.
     */
    func isSetupStop() -> Bool {
        var areEqual: Bool = false
        
        if (stops.count == 2) {
            let stopOne = stops[0]
            let stopTwo = stops[1]
            areEqual = stopOne == stopTwo
            return areEqual
        }
        
        return areEqual
    }
    
}