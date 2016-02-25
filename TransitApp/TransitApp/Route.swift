//
//  Route.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

struct Route {
    var type: String
    var provider: Provider
    var segments: [Segment]
    var price: Price
    
    init(type: String, provider: Provider, segments: [Segment], price: Price){
        self.type = type
        self.provider = provider
        self.segments = segments
        self.price = price
    }
}
