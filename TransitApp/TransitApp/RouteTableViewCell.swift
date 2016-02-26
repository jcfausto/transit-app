//
//  RouteTableViewCell.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 25/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
