//
//  RouteSegmentsDetailViewController.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit
import GoogleMaps
import Polyline
import CoreLocation

class RouteSegmentsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var route: Route?
    
    @IBOutlet weak var mapViewContainer: GMSMapView!
    
    // MARK: properties
    
    @IBOutlet weak var routeSegmentsView: RouteSegmentsView!
    @IBOutlet weak var routeDurationLabel: UILabel!
    @IBOutlet weak var routeSummaryLabel: UILabel!
    @IBOutlet weak var segmentsTableView: UITableView!
    
    // MARK: Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doFillRouteInformation(self)
        
        initMapView(self)
        
        // Observers
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"performSegmentSelection:", name: "RSVButtonTapped", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Deinitialization
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: TableView protocols compliance
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let route = self.route {
            return route.segments.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier = "RouteSegmentsDetailTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RouteSegmentsDetailTableViewCell
        
        doInitializeCell(cell, indexPath: indexPath)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        doPlotSegmentOnTheMap(indexPath)
    }

}

// MARK: Custom functions

extension RouteSegmentsDetailViewController {
    
    
    /**
    Fill the view with the route information
    */
    func doFillRouteInformation(rsViewController: RouteSegmentsDetailViewController) {
        if let route = rsViewController.route {
            rsViewController.navigationItem.title = route.provider
            rsViewController.routeSegmentsView.segments = route.segments
            rsViewController.routeSummaryLabel.text = route.summary
            rsViewController.routeDurationLabel.text = route.duration.stringValueInMinutes
        }
    }
    
    // MARK: Cell initialization
    func doInitializeCell(cell: RouteSegmentsDetailTableViewCell, indexPath: NSIndexPath) {
        
        if let route = self.route {
    
            let segment = route.segments[indexPath.row]
            let firstStop = route.segments[indexPath.row].stops.first
            let lastStop = route.segments[indexPath.row].stops.last
    
            //Segment vertical line color
            cell.segmentDetailVerticalLineView.fillColor = segment.color
    
            //Segment duration in minutes
            if let firstStop = firstStop, lastStop = lastStop {
                cell.segmentEstimatedDurationLabel.text = lastStop.time.timeIntervalSinceDate(firstStop.time).stringValueInMinutes
            }
    
            //Departure and arrival information
            if let firstStop = firstStop {
                cell.segmentTimeLabel.text = "Departure at \(firstStop.time.stringValueWithHourAndMinute)"
    
                if let name = firstStop.name {
                    if (!name.isEmpty) {
                        cell.segmentNameLabel.text = "starting at \(name)"
                    }
                }
    
                var destinationSummary: String = ""
    
                if (!segment.travelMode.isEmpty) {
                    destinationSummary = destinationSummary + "\(segment.travelMode)"
                }
    
                if let lastStop = lastStop {
                    if let name = lastStop.name {
                        if (!name.isEmpty) {
                            var prepString = "to"
    
                            if segment.isSetupStop() {
                                prepString = "at"
                            }
    
                            destinationSummary = destinationSummary + " \(prepString) \(name)"
                        }
                    }
                }
    
                cell.segmentTravelModeLabel.text = destinationSummary
    
    
            }
    
    
            //Last segment additional information
            if indexPath.row == route.segments.count-1 {
                if let lastStop = lastStop {
                    cell.segmentFinishTimeLabel.text = "Estimated arrival at \(lastStop.time.stringValueWithHourAndMinute)"
    
                    cell.segmentDetailVerticalLineView.lastSegment = true
                }
            }
    
        }

    }
    
    // MARK: Map initialization, centered initially for the purpose of this application in Berlin
    
    func initMapView(rsViewController: RouteSegmentsDetailViewController) {
        
        //This initial center position could come from a .plist config file.
        let camera = GMSCameraPosition.cameraWithLatitude(52.524370, longitude: 13.410530, zoom: 15)
        rsViewController.mapViewContainer.camera = camera
        rsViewController.mapViewContainer.myLocationEnabled = true
    }
    
    /**
     Plot a segment on the map
    */
    func doPlotSegmentOnTheMap(indexPath: NSIndexPath) {
        
        if let route = self.route {
            
            let selectedSegment: Segment = route.segments[indexPath.row]
            
            //If the segment doesn't have a polyline, means that is a stop in the same place
            //for some acton (bike or car returnin, car setup, etc)
            if (!selectedSegment.polyline.isEmpty) {
                
                let decodePolyline = Polyline(encodedPolyline: selectedSegment.polyline)
                let decodedPath: [CLLocationCoordinate2D]? = decodePolyline.coordinates
                let path = GMSMutablePath()
                
                if let decodedPath = decodedPath {
                    for location in decodedPath {
                        path.addCoordinate(location)
                    }
                }
                
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = selectedSegment.color
                polyline.strokeWidth = 2.0
                
                
                var locationPosition = path.coordinateAtIndex(0) //First location
                
                switch indexPath.row {
                case 0:
                    let marker = GMSMarker(position: locationPosition)
                    marker.icon = GMSMarker.markerImageWithColor(selectedSegment.color)
                    marker.title = selectedSegment.name
                    marker.map = self.mapViewContainer
                    
                    //When there's only one segment, the index row 0 represents both the starting
                    //and stopping positions.
                    if route.segments.count == 1 {
                        let finalPosition = path.coordinateAtIndex(path.count()-1) //Last location
                        let finalMarker = GMSMarker(position: finalPosition)
                        finalMarker.icon = GMSMarker.markerImageWithColor(selectedSegment.color)
                        finalMarker.map = self.mapViewContainer
                    }
                    
                case route.segments.count-1:
                    locationPosition = path.coordinateAtIndex(path.count()-1) //Last location
                    let marker = GMSMarker(position: locationPosition)
                    marker.icon = GMSMarker.markerImageWithColor(selectedSegment.color)
                    marker.title = selectedSegment.name
                    marker.map = self.mapViewContainer
                default: break
                }
                
                polyline.map = self.mapViewContainer
                
                self.mapViewContainer.animateToLocation(locationPosition)
                
            }
            
        }
    }
    
    /**
     This method will be invoked every time that the RouteSegmentsView notify for an 
     RSVButtonTapped event
     */
    func performSegmentSelection(notification: NSNotification) {
        
        let userInfo = notification.userInfo as! [String: AnyObject]
        let button = userInfo["button"] as! RouteSegmentButton?
        
        if let button = button {
            let indexPath = NSIndexPath(forRow: button.index, inSection: 0)
            self.segmentsTableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            self.tableView(self.segmentsTableView, didSelectRowAtIndexPath: indexPath)
        }
        
    }
    
}
