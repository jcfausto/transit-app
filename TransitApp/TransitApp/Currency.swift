//
//  Currency.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

//Not need to be a class here, a struct will be fine
struct Currency {
    var symbol:String
    
    init(symbol:String){
        self.symbol = symbol
    }
}