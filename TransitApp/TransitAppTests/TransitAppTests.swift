//
//  TransitAppTests.swift
//  TransitAppTests
//
//  Created by Julio Cesar Fausto on 23/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import XCTest
//To decode json to models
import Unbox
@testable import TransitApp

class TransitAppTests: XCTestCase {
    
    var dataPath: String!
    
    override func setUp() {
        super.setUp()
        self.dataPath = NSBundle.mainBundle().pathForResource("data", ofType: "json")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     Test if the JSON that serves as data is being accessible
    */
    func testCanLoadData() {
        XCTAssertNotNil(NSData(contentsOfFile: self.dataPath))
    }
    
    /**
     Test if the decoding with Unbox is working properly 
     with the application models.
     */
    func testCanDecodeDataFromJsonWithUnbox(){
        if let data = NSData(contentsOfFile: self.dataPath) {
            if let routes: Routes? = Unbox(data) {

                XCTAssertNotNil(routes)
            } else {
                XCTFail("Error while decoding JSON to Models")
            }
            
        }

    }
    
    /**
     Testing the NSInterval+Extension created to provide a 
     string representation of an inveval in minutes.
     */
    func testCanGetTimeIntervalInStringFormatMinutes(){
        let interval: NSTimeInterval = 6000
        XCTAssertEqual(interval.stringValueInMinutes, "40 min")
    }

    
}
