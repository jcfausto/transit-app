//
//  Price.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation


class Price {
    
    var amount: Double = 0.0
    var currency: Currency?
    
    init(amount: Double, currency: Currency) {
        self.amount = amount
        self.currency = currency
    }
    
}