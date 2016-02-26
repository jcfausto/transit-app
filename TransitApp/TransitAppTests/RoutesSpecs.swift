//
//  RoutesSpecs.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 25/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class RoutesSpecs: QuickSpec {
    
    //MARK: Support routines
    
    func createSegmentOne() -> Segment {
        
        let stopOne = Stop(name: "", latitude: 52.530227, longitude: 52.530227, time: NSDate(datetimeString: "2015-04-17T13:30:00+02:00"))
        let stopTwo = Stop(name: "U Rosa-Luxemburg-Platz", latitude: 52.528187, longitude: 13.410404, time: NSDate(datetimeString: "2015-04-17T13:38:00+02:00"))
        
        let stops = [stopOne, stopTwo]
        
        let travelMode = "Walking"
        
        //Used an extension here
        let color = UIColor(hexString: "#b1ecc")
        
        let iconUrl = "https://d3m2tfu2xpiope.cloudfront.net/vehicles/walking.svg"
        let polyline = "uvr_I{yxpABuAFcAp@yHvAwNr@iGPwAh@a@jAg@"
        
        return Segment(name: "", numStops: 0, description: "", stops: stops, travelMode: travelMode, color: color, iconUrl: iconUrl, polyline: polyline)
        
    }
    
    func createSegmentTwo() -> Segment {
        
        let stopOne = Stop(name: "U Rosa-Luxemburg-Platz", latitude: 52.528187, longitude: 13.410404, time: NSDate(datetimeString: "2015-04-17T13:38:00+02:00"))
        let stopTwo = Stop(name: "S+U Alexanderplatz", latitude: 52.522074, longitude: 13.413595, time: NSDate(datetimeString: "2015-04-17T13:40:00+02:00"))
        
        let stops = [stopOne, stopTwo]
        
        let travelMode = "Subway"
        
        //Used an extension here
        let color = UIColor(hexString: "#d64820")
        
        let iconUrl = "https://d3m2tfu2xpiope.cloudfront.net/vehicles/subway.svg"
        let polyline = "elr_I_fzpAfe@_Sf]dFr_@~UjCbg@yKvj@lFfb@`C|c@hNjc@"
        
        return Segment(name: "U2", numStops: 2, description: "S+U Potsdamer Platz", stops: stops, travelMode: travelMode, color: color, iconUrl: iconUrl, polyline: polyline)
    }
    
    override func spec() {
       
        describe("Routes"){
            
            var routes: Routes!
            
            beforeEach {

                let segmentOne = self.createSegmentOne()
                let segmentTwo = self.createSegmentTwo()
                let price = Price(amount: 10.50, currency: "EUR")
                
                let routeOne = Route(type: "public_transport", provider: "vbb", segments: [segmentOne, segmentTwo], price: price)
                let routeTwo = Route(type: "public_transport", provider: "taxi", segments: [segmentOne, segmentTwo], price: price)
                
                routes = Routes(withRoutes: [routeOne, routeTwo])
            }
            
            it("has more than one route"){
                expect(routes.routes.count).to(beGreaterThan(1))
            }
            
            
            
        }
        
    }

    
}
