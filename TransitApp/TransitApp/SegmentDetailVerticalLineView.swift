//
//  SegmentDetailVerticalLineView.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 27/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import UIKit

@IBDesignable
class SegmentDetailVerticalLineView: UIView {

    /**
     The color of the shape
     */
    @IBInspectable var fillColor: UIColor = UIColor.grayColor()
    
    /**
     Set this property to false if you want to not draw the line in the 
     entire height of the view.
     */
    @IBInspectable var verticalLineOverflow: Bool = true

    /**
     Indicates if it is the last segment to be drawed. If this happen
     the verticalLineOverflow property will not be considered and the 
     line will be drawed with the height equals to bounds.height
     */
    var lastSegment: Bool = false
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // MARK: Drawing the vertical line
        
        //set up the width variables
        //for the horizontal stroke
        let lineWidth: CGFloat = min(bounds.width, bounds.height) * 0.7
        
        //create the path
        let linePath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        linePath.lineWidth = lineWidth
        
        var lineHeight = bounds.height
        
        if lastSegment {
            lineHeight = bounds.height - 10
        }
        
        //move to the start of the vertical stroke
        linePath.moveToPoint(CGPoint(
            x:bounds.width/2,
            y:lineHeight))
        
        //add the end point to the vertical stroke
        linePath.addLineToPoint(CGPoint(
            x:bounds.width/2,
            y:0))
        
        //set the stroke color
        fillColor.setStroke()
        
        //draw the stroke
        linePath.stroke()
        
        // MARK: Drawing the circle shape at the bottom
        
        let ovalRect = CGRect(x: 0, y: bounds.height-15, width: bounds.width, height: 15)
        
        let path = UIBezierPath(ovalInRect: ovalRect)
        
        fillColor.setFill()
        
        path.fill()
        
    }
}
