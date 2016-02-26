//
//  DateFormatter.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 25/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation


class DateFormatter {
    
    static let sharedInstance = DateFormatter()
    
    let formatterForJsonConversion: NSDateFormatter
    
    init() {
        self.formatterForJsonConversion = NSDateFormatter()
        self.formatterForJsonConversion.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        self.formatterForJsonConversion.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        self.formatterForJsonConversion.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    }
    
}