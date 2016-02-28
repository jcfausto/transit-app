//
//  RouteSpecs.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class RouteSpecs: QuickSpec {
    
    
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
    
    //MARK: Testing routines
    
    override func spec() {
        
        describe("Route"){
            
            var route: Route!
            
            beforeEach {
                let type = "public_transport"
                let provider = "vbb"
                
                let segmentOne = self.createSegmentOne()
                let segmentTwo = self.createSegmentTwo()
                
                let segments = [segmentOne, segmentTwo]
                
                let price = Price(amount: 0.0, currency: "EUR")
                
                route = Route(type: type, provider: provider, segments: segments, price: price)
            }
            
            it("has a type"){
                expect(route.type).to(equal("public_transport"))
            }
            
            it("has a provider"){
                expect(route.provider).to(equal("vbb"))
            }
            
            it("has two segments"){
                expect(route.segments.count).to(equal(2))
            }
            
            it("has a price"){
                expect(route.price!.amount).to(equal(0.0))
            }
            
            it("has a duration"){
                let start = NSDate(datetimeString: "2015-04-17T13:30:00+02:00")
                let finish = NSDate(datetimeString: "2015-04-17T13:40:00+02:00")
                let expected_duration = finish.timeIntervalSinceDate(start)
                expect(route.duration).to(equal(expected_duration))
            }
            
            it("has a timestring representation of starting point"){
                expect(route.timeStringRepresentation(.Start)).to(equal("8:30"))
            }
            
            it("has a timestring representation of finishing point"){
                expect(route.timeStringRepresentation(.Finish)).to(equal("8:40"))
            }
            
            it("has a summary"){
                expect(route.summary).to(equal("EUR: 0.0 | 8:30 -> 8:40"))
            }
            
        }
        
    }
}
