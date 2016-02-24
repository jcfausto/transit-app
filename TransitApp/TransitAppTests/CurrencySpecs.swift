//
//  CurrencySpec.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Quick
import Nimble
@testable import TransitApp

class CurrencySpecs: QuickSpec {
    
    override func spec() {
        
        describe("Currency") {
            
            var currency: Currency!
            
            context("initialization") {
                beforeEach {
                    let currencySymbol = "EUR"
                    currency = Currency(aSymbol: currencySymbol)
                }
                
                it("initializes a new currency"){
                    expect(currency).toNot(beNil())
                }
                
                it("associates correctly the currency symbol"){
                    expect(currency.symbol).to(equal("EUR"))
                }
                
            }
            
        }
        
    }
    
}

