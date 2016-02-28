//
//  RouteTableViewController.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit
import Unbox

class RouteTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var routes: Routes?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadRoutesFakeData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let routes = self.routes?.routes {
            return routes.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RouteTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RouteTableViewCell
        
        if let route: Route = self.routes?.routes[indexPath.row] {
            cell.routeProviderLabel.text = route.provider
            
            cell.routeSummaryLabel.text = route.summary
            
            //Uses the NSTimeInterval+Extension stringValueInMinutes
            cell.routeDurationLabel.text = route.duration.stringValueInMinutes
            
            cell.routeSegmentsView.segments = route.segments
        }

        return cell
    }

    // MARK: - Navigation

    // Sending the selected route to the next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRouteSegments"{
            if let row = tableView.indexPathForSelectedRow?.row {
                self.sendCurrentRouteToSegue(row, segue: segue)
            }
        }
    }
}


// MARK: Custom methods

extension RouteTableViewController {
    
    /**
     Sends the current route (associated with the selected cell) to a segue
     */
    func sendCurrentRouteToSegue(routeIndex: Int, segue: UIStoryboardSegue) {
        let destinationViewController = segue.destinationViewController as! RouteSegmentsDetailViewController
        if let route: Route = self.routes?.routes[routeIndex] {
            destinationViewController.route = route
        }
    }
    
    /**
     Loads the JSON data. THIS METHOD MUST BE REFACTORED TO A SERVICE LAYER
     */
    func loadRoutesFakeData() {
        let dataProvider = DataProvider()
        self.routes = dataProvider.searchForRoutes()
    }
    
}
