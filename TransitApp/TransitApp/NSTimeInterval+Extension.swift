//
//  NSTimeInterval+Extension.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation

extension NSTimeInterval {
    var stringValueInMinutes: String {
        let interval = Int(self)
        let minutes = (interval / 60) % 60
        return String(format: "%02d min", minutes)
    }
}