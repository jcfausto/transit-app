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
    
    var segments: [Segment]? {
        
        didSet {
            if let segments = self.segments {
                if segmentButtons.isEmpty {
                    for segment: Segment in segments {
                        
                        let segmentButtom = UIButton()
                        segmentButtom.backgroundColor = segment.color
                        segmentButtons += [segmentButtom]
                        addSubview(segmentButtom)
                    }
                }

            }
            
            
            setNeedsLayout()
        }
    }
    
    var segmentButtons = [UIButton]()
    

    // MARK: initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in segmentButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        var width = (buttonSize + spacing)
        
        if let segments = self.segments {
            width = ((buttonSize + spacing) * (segments.count))
        }
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Custom methods
    

}
