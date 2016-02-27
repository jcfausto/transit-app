//
//  StopSpecs.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class StopSpecs: QuickSpec {
    
    override func spec() {
        
        describe("Stop") {
            
            var stop: Stop!
            
            beforeEach {
                let latitude = 52.530227
                let longitude = 13.403356
                let name = "Stop1"
                let time = NSDate(datetimeString: "2015-04-17T13:38:00+02:00")
                
                stop = Stop(name: name, latitude: latitude, longitude: longitude, time: time)
            }
            
            it("has a name"){
                expect(stop.name).to(equal("Stop1"))
            }
            
            it("has a latitude") {
                expect(stop.latitude).to(equal(52.530227))
            }
            
            it("has a longitude") {
                expect(stop.longitude).to(equal(13.403356))
            }
            
            it("has a time") {
                expect(stop.time).to(equal(NSDate(datetimeString: "2015-04-17T13:38:00+02:00")))
            }
            
    
            
        }
        
    }
}
