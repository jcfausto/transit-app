//
//  Segment.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import UIKit

struct Segment {
    var name: String?
    var numStops: Int
    var description: String?
    var stops: [Stop]
    var travelMode: TravelMode
    var color: UIColor
    var iconUrl: String
    var polyline: String
    
    init(name: String?, numStops: Int, description: String?, stops: [Stop],
        travelMode: TravelMode, color: UIColor, iconUrl: String, polyline: String)
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
