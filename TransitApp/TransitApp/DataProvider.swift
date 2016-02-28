//
//  DataProvider.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 28/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import Unbox

/**
 A data provider that currently serves only fake data provided via a json file.
*/
struct DataProvider {
    
    func searchForRoutes() -> Routes? {
        var routes: Routes?
        
        if let dataPath = NSBundle.mainBundle().pathForResource("data", ofType: "json") {
            if let data = NSData(contentsOfFile: dataPath) {
                routes = Unbox(data)
            }
        }
        
        return routes
    }
    
}
