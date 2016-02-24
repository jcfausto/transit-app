//
//  Price.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

//Not need to be a class here, a struct will be fine
struct Price {
    
    var amount: Double
    var currency: Currency
    
    init(amount: Double, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
}