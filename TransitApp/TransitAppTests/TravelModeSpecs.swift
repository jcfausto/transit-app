//
//  TravelModeSpec.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class TravelModeSpecs: QuickSpec {
    
    override func spec() {
        
        describe("Travel Mode") {
            
            var travelMode: TravelMode!
            
            context("initialization") {
                beforeEach {
                    let aMode = "Walk"
                    travelMode = TravelMode(aMode: aMode)
                }
                
                it("initializes a new travel mode"){
                    expect(travelMode).toNot(beNil())
                }
                
                it("associates correctly the mode"){
                    expect(travelMode.mode).to(equal("Walk"))
                }
                
                it("changes travel mode correctly"){
                    travelMode.mode = "Train"
                    expect(travelMode.mode).to(equal("Train"))
                }
                
            }
            
        }
        
    }
    
}