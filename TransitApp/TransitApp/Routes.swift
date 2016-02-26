//
//  Routes.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 25/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

struct Routes: Unboxable {
    let routes: [Route]
    
    init(withRoutes routes: [Route]){
        self.routes = routes
    }
    
    init(unboxer: Unboxer) {
        self.routes = unboxer.unbox("routes")
    }
}
