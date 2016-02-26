//
//  Route.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

/**
 This enumeration represents a certain position in the route
 The two supoorted ones are:
 - Start : The first position in the route
 - Finish : The last position in the route
*/
enum RoutePosition {
    case Start
    case Finish
}

struct Route: Unboxable {
    var type: String
    var provider: String
    var segments: [Segment]
    var price: Price?

    
    init(type: String, provider: String, segments: [Segment], price: Price){
        self.type = type
        self.provider = provider
        self.segments = segments
        self.price = price
    }
    
    init(unboxer: Unboxer) {
        self.type = unboxer.unbox("type")
        self.provider = unboxer.unbox("provider")
        self.segments = unboxer.unbox("segments")
        self.price = unboxer.unbox("price")
    }
}


// MARK: Route struct extension
extension Route {
    
    func timeStringRepresentation(from: RoutePosition) -> String {
        
        var result: String = ""
        
        switch from {
        case RoutePosition.Start:
            if let time = self.segments.first?.stops.first?.time {
                result = time.stringValueWithHourAndMinute
            }
        case RoutePosition.Finish:
            if let time = self.segments.last?.stops.last?.time {
                result += time.stringValueWithHourAndMinute
            }
        }
        
        return result

    }
    
    /**
     This is a computed var based on the route's segment stops.
     The duration is computed by the difference between the finish
     point time and the start point time.
     If the route does not have at least two segments, the
     duration will return 0.
     */
    var duration: NSTimeInterval {
        
        guard let finish = self.segments.last?.stops.last?.time,
            let start = self.segments.first?.stops.first?.time else {
                return 0
        }
        
        return finish.timeIntervalSinceDate(start)
    }
    
    /**
     A summary string of the route containing the price and the start and finish time.
     */
    var summary: String {
        
        var result: String = ""
        
        if let price = self.price {
            result += "\(price.currency): \(price.amount)"
        }
        
        let start = self.timeStringRepresentation(RoutePosition.Start)
        let finish = self.timeStringRepresentation(RoutePosition.Finish)
        
        if (start != "" && finish != "") {
            if result != "" {
                result += " | \(start) -> \(finish)"
            } else {
                result += "\(start) -> \(finish)"
            }
        }
        
        
        return result
    }
    
}