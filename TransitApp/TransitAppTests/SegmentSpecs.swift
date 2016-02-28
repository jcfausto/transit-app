//
//  SegmentSpecs.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import TransitApp

class SegmentSpecs: QuickSpec {
    
    //MARK: Support routines
    
    func createDifferentStops() -> [Stop] {
        
        let stopOne = Stop(name: "S+U Alexanderplatz", latitude: 52.530227, longitude: 52.530227, time: NSDate(datetimeString: "2015-04-17T13:30:00+02:00"))
        let stopTwo = Stop(name: "U Rosa-Luxemburg-Platz", latitude: 52.528187, longitude: 13.410404, time: NSDate(datetimeString: "2015-04-17T13:38:00+02:00"))
        
        return [stopOne, stopTwo]
    }
    
    func createEqualStops() -> [Stop] {
        
        let stopOne = Stop(name: "U Rosa-Luxemburg-Platz", latitude: 52.528187, longitude: 13.410404, time: NSDate(datetimeString: "2015-04-17T13:38:00+02:00"))
        let stopTwo = Stop(name: "U Rosa-Luxemburg-Platz", latitude: 52.528187, longitude: 13.410404, time: NSDate(datetimeString: "2015-04-17T13:38:00+02:00"))
        
        return [stopOne, stopTwo]
    }
    
    func createSegment(withEqualStops: Bool) -> Segment {
        let name = "Segment1"
        let numStops = 0
        let description = "A test segment"
        
        let stops: [Stop]
        
        switch withEqualStops{
        case true:
            stops = createEqualStops()
        case false:
            stops = createDifferentStops()
        }
        
        let travelMode = "Walking"
        
        //Used an extension here
        let color = UIColor(hexString: "#b1ecc")
        
        let iconUrl = "https://d3m2tfu2xpiope.cloudfront.net/vehicles/walking.svg"
        let polyline = "uvr_I{yxpABuAFcAp@yHvAwNr@iGPwAh@a@jAg@"
        
        return Segment(name: name, numStops: numStops, description: description, stops: stops, travelMode: travelMode, color: color, iconUrl: iconUrl, polyline: polyline)
    }
    
    // MARK: Specs
    
    override func spec() {

        describe("Segment"){
            
            var segment: Segment!
            
            beforeEach {
                segment = self.createSegment(false)
            }
            
            it("has a name"){
                expect(segment.name).to(equal("Segment1"))
            }
            
            it("has a number of stops"){
                expect(segment.numStops).to(equal(0))
            }
            
            it("has a description"){
                expect(segment.description).to(equal("A test segment"))
            }
            
            
            context("Segment stops"){
                it("has two stops"){
                    expect(segment.stops.count).to(equal(2))
                }
                
                it("stop 1 is at S+U Alexanderplatz "){
                    expect(segment.stops[0].name).to(equal("S+U Alexanderplatz"))
                }
                
                //it("stop 1 latitude to be 52.5302"){
                //    expect(segment.stops[0].latitude).to(equal(52.5302))
                //}
                
                //it("stop 1 longitude to be 52.5302"){
                //    expect(segment.stops[0].longitude).to(equal(52.5302))
                //}
                
                it("stop 1 time equals to 2015-04-17T13:38:00+02:00"){
                    //Expected value converted to UTC
                    expect(segment.stops[0].time.stringRepresentation).to(equal("2015-04-17 08:30:00.0000"))
                }
                
                it("stop 2 is at U Rosa-Luxemburg-Platz"){
                   expect(segment.stops[1].name).to(equal("U Rosa-Luxemburg-Platz"))
                }
                
                //it("stop 2 latitude to be 52.522074"){
                //    expect(segment.stops[1].latitude).to(equal(52.5282))
                //}
                
                //it("stop 2 longitude to be 13.413595"){
                //    expect(segment.stops[1].longitude).to(equal(13.4104))
                //}
                
                it("stop 2 time equals to 2015-04-17T13:40:00+02:00"){
                    //Expected value converted to UTC
                    expect(segment.stops[1].time.stringRepresentation).to(equal("2015-04-17 08:38:00.0000"))
                }
                
            }
            
            it("has a travel mode"){
                expect(segment.travelMode).to(equal("Walking"))
            }
            
            it("has a color"){
                expect(segment.color).to(equal(UIColor(hexString: "#b1ecc")))
            }
            
            it("has a icon url"){
                expect(segment.iconUrl).to(equal("https://d3m2tfu2xpiope.cloudfront.net/vehicles/walking.svg"))
            }
            
            it("has a polyline"){
                expect(segment.polyline).to(equal("uvr_I{yxpABuAFcAp@yHvAwNr@iGPwAh@a@jAg@"))
            }
            
            it("is a setup stop when has only two and this two are equal"){
                segment = self.createSegment(true)
                expect(segment.isSetupStop()).to(equal(true))
            }
            
            it("is not a setup stop when has only two and this two are not equal"){
                segment = self.createSegment(false)
                expect(segment.isSetupStop()).to(equal(false))
            }
            
        }
    }
}
