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
//To test polylines
import CoreLocation
import Polyline

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
    
    /**
    Testing if google maps SKD could be initialized properly
    */
    func testCanInitializeGoogleMapsSdkWhenApiKeyIsProvided(){
        if let key = ApiKeysHelper.sharedInstance.getGoogleMapsSdkApiKey() {
            if !key.isEmpty {
                let gmapsSdk = GoogleMapsSDKInitializer()
                gmapsSdk.doSetup()
                XCTAssertTrue(gmapsSdk.state)
            }
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func testFailToInitializeGoogleMapsSdkWhenApiKeyIsNotProvided(){
        if let key = ApiKeysHelper.sharedInstance.getGoogleMapsSdkApiKey() {
            if key.isEmpty {
                let gmapsSdk = GoogleMapsSDKInitializer()
                gmapsSdk.doSetup()
                XCTAssertFalse(gmapsSdk.state)
            }
        } else {
            XCTAssertFalse(false)
        }

    }
    
    /**
    Testing Polylines decoding with 6 digit precision
    Polyline with 9 points for testing:
    Points: 
     - 0: 52.528187, 13.410404
     - 1: 52.522074, 13.413595
     - 2: 52.517229, 13.412454
     - 3: 52.512006, 13.408768
     - 4: 52.511305, 13.40235
     - 5: 52.513363, 13.395347
     - 6: 52.512168, 13.389711
     - 7: 52.511521, 13.383796
     - 8: 52.509067, 13.37798
    */
    func testCanDecodePolyline(){
        let polyline = Polyline(encodedPolyline: "elr_I_fzpAfe@_Sf]dFr_@~UjCbg@yKvj@lFfb@`C|c@hNjc@")
        let coordinates: [CLLocationCoordinate2D]? = polyline.coordinates
        let decodedLocations: [CLLocation]? = polyline.locations
        XCTAssertNotNil(decodedLocations)
        XCTAssertNotNil(coordinates)
        XCTAssertEqual(coordinates!.count, 9)
        
        if let decodedLocations = decodedLocations {
            let initialLocation = decodedLocations[0]
            //There are some issues with precision. due to this, the expected value will be rounded to 5 digits precision.
            XCTAssertEqual(initialLocation.coordinate.latitude, 52.52819)
            XCTAssertEqual(initialLocation.coordinate.longitude, 13.4104)
        }else {
            XCTFail("Locations were not decoded properly")
        }
        
        //XCTAssertEqual(coordinateOne.latitude, 52.528187)
    }
    
    /**
     Tests the SVGIconCache object
     */
    func testCanStoreSVGDataToSVGCache() {
        let svgUrl = "https://d3m2tfu2xpiope.cloudfront.net/vehicles/walking.svg"
        let expectation = expectationWithDescription("testCanStoreSVGDataToSVGCache")
        
        if let url = NSURL(string: svgUrl) {
            
            let resourceName = url.lastPathComponent
        
            let request = NSURLRequest(URL: url)
         
            let downloadTask = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                
                if let svgData = data as NSData? {
                    
                    let cache = SVGIconCache()
                    cache.saveSVG(svgData, fileName: resourceName!)
                    
                    let cachedData = cache.retrieveSVG(resourceName!)
                    
                    if let cachedData = cachedData {
                        let equalData = svgData.isEqualToData(cachedData)
                        XCTAssertTrue(equalData)
                    } else {
                        XCTFail("It was not possible to use the SVG cache properly")
                    }
                    
                }
                
                expectation.fulfill()
            }
            
            downloadTask.resume()
            
        } else {
            XCTFail("Error trying to convert the SVG url")
        }
        
        waitForExpectationsWithTimeout(10.0, handler:nil)
        
    }
    
    /**
    Teste the data provider that currently only loads data from json
     */
    func testCandSearchForRoutes(){
        let dataProvider = DataProvider()
        let routes = dataProvider.searchForRoutes()
        XCTAssertNotNil(routes)
    }
    
    /**
    Test the NSDate+Extension
    */
    func testCanGetStringValueWithHourAndMinuteFromNSDate() {
        let date = NSDate(datetimeString: "2015-04-17T13:56:00+02:00")
        let hoursAndMinutes = date.stringValueWithHourAndMinute
        //Value in local timezone
        XCTAssertEqual(hoursAndMinutes, "8:56")
    }
    
    /**
    Test the UIColor+Extension
    */
    func testCanCreateUIColorFromDifferentHexStrings() {
        let color3 = UIColor(hexString: "#FFF")
        XCTAssertNotNil(color3)
        
        let color6 = UIColor(hexString: "#FFFFFF")
        XCTAssertNotNil(color6)
        
        let color8 = UIColor(hexString: "#FFFFFF00")
        XCTAssertNotNil(color8)
        
        let colorDefault = UIColor(hexString: "#FFFFFFFFFF")
        XCTAssertNotNil(colorDefault)
    }
    
}
