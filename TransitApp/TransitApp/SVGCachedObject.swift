//
//  SVGCachedObject.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 28/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation


class SVGCachedObject {
    var data: NSData
    var fileName: String
    
    init(data: NSData, fileName: String){
        self.data = data
        self.fileName = fileName
    }
}