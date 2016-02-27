//
//  GoogleMapsSDKInitializer.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import GoogleMaps

class GoogleMapsSDKInitializer {
    
    var state: Bool = false
    
    // MARK: Google maps ios SDK initialization
    
    func doSetup() {
        
        if let key = ApiKeysHelper.sharedInstance.getGoogleMapsSdkApiKey() {
            if !key.isEmpty {
                GMSServices.provideAPIKey(key)
                self.state = true
            }

        }
        
    }
}
