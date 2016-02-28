//
//  RouteSegmentsView.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 26/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit

class RouteSegmentsView: UIView {
    
    // MARK: Properties
    var spacing = 5
    
    var segmentButtons = [UIButton]()
    
    /**
     This is a computed var for segments. When the segment for 
     the cell that is being created in the table view controller was
     set, this view prepares its content by adding the subviews that
     representing each segment.
     */
    var segments: [Segment]? {
        
        didSet {
            if let segments = self.segments {
                if segmentButtons.isEmpty {
                    for segment: Segment in segments {
                        
                        let segmentButtom = RouteSegmentButton()
                        segmentButtom.fillColor = segment.color
                        segmentButtom.svgIconUrl = NSURL(string: segment.iconUrl)
                        segmentButtons += [segmentButtom]
                        //Store the index to be used later to identify the button in the tap action
                        segmentButtom.index = segmentButtons.count-1
                        segmentButtom.addTarget(self, action: "segmentButtonTapped:", forControlEvents: .TouchDown)
                        addSubview(segmentButtom)
                    }
                }

            }
            
            setNeedsLayout()
        }
    }

    // MARK: initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        // Set the button's width and height
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in segmentButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
    }

    // MARK: Custom methods
    
    /**
    It is necessary to remove all the subviews (buttons)that was
    used in the cell that was recycled in order to not experience
    painting erros in the view. If this cleanup doesn't occur when 
    the user scrolls the table the icons will sometimes be wrong.
    */
    func prepareForReuse() -> Void {
        
        //Removing unused subviews.
        for buttom in segmentButtons {
            buttom.removeFromSuperview()
        }
        
        //Resetting buttons reference
        segmentButtons.removeAll()
        
        //Resetting segments
        self.segments?.removeAll()
    }
    
    // MARK: button tap action
    
    func segmentButtonTapped(button: RouteSegmentButton) {
        //Setting up and a notification to be watched by observers
        NSNotificationCenter.defaultCenter().postNotificationName("RSVButtonTapped", object: self, userInfo: ["button":button])
    }
    

}
