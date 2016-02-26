//
//  Route.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 24/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

struct Route: Unboxable {
    var type: String
    var provider: String
    var segments: [Segment]
    var price: Price?
    
    init(type: String, provider: String, segments: [Segment], price: Price){
        self.type = type
        self.provider = provider
        self.segments = segments
        self.price = price
    }
    
    init(unboxer: Unboxer) {
        self.type = unboxer.unbox("type")
        self.provider = unboxer.unbox("provider")
        self.segments = unboxer.unbox("segments")
        self.price = unboxer.unbox("price")
    }
}