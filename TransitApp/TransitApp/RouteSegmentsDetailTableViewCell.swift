//
//  RouteSegmentsDetailTableViewCell.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit

class RouteSegmentsDetailTableViewCell: UITableViewCell {

    // MARK: Properties
    
    @IBOutlet weak var segmentTimeLabel: UILabel!
    @IBOutlet weak var segmentFinishTimeLabel: UILabel!
    @IBOutlet weak var segmentNameLabel: UILabel!
    @IBOutlet weak var segmentTravelModeLabel: UILabel!
    @IBOutlet weak var segmentDetailVerticalLineView: SegmentDetailVerticalLineView!
    @IBOutlet weak var segmentEstimatedDurationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
