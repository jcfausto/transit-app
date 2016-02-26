//
//  Price.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

//Not need to be a class here, a struct will be fine
struct Price: Unboxable {
    
    var amount: Double
    var currency: String
    
    init(amount: Double, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    init(unboxer: Unboxer) {
        self.amount = unboxer.unbox("amount")
        self.currency = unboxer.unbox("currency")
    }
    
}