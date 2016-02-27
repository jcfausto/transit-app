//
//  RouteSegmentsDetailViewController.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit
import GoogleMaps

class RouteSegmentsDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var route: Route?
    
    @IBOutlet weak var mapViewContainer: GMSMapView!
    
    // MARK: Segments View properties
    @IBOutlet weak var routeSegmentsView: RouteSegmentsView!
    @IBOutlet weak var routeDurationLabel: UILabel!
    @IBOutlet weak var routeSummaryLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let route = self.route {
            self.navigationItem.title = route.provider
            self.routeSegmentsView.segments = route.segments
            self.routeSummaryLabel.text = route.summary
            self.routeDurationLabel.text = route.duration.stringValueInMinutes
        }
        
        initMapView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Map initialization
    func initMapView() {
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        
        self.mapViewContainer.camera = camera
        
        self.mapViewContainer.myLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapViewContainer
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
        
        if let route = self.route {
            
            if let firstStop = route.segments[indexPath.row].stops.first {
                cell.segmentTimeLabel.text = firstStop.time.stringValueWithHourAndMinute
            }
            
            if indexPath.row == route.segments.count-1 {
                if let lastStop = route.segments[indexPath.row].stops.last {
                    cell.segmentFinishTimeLabel.text = lastStop.time.stringValueWithHourAndMinute
                }
            }

        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let route = self.route {
            print(route.segments[indexPath.row].name)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
