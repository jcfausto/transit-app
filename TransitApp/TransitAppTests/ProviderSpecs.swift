//
//  ProviderSpecs.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class ProviderSpecs: QuickSpec {
    
    override func spec() {
        
        describe("Provider") {
            var provider: Provider!
            
            beforeEach {
                let name = "ProviderX"
                
                provider = Provider(name: name)
            }
            
            it("have a name"){
                expect(provider.name).to(equal("ProviderX"))
            }
        }
        
    }
    
}
