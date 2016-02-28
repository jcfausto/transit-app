//
//  RouteSegmentButtom.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 27/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import UIKit
import SVGKit

/**
 This is an UIButton capable of retrieve an SVG from some URL, convert it
 to an image and assign it as its own image for the normal state.
 It is dependable on the SVGKit framework
 */

@IBDesignable
class RouteSegmentButton: UIButton {

    /**
     The shape's icon url. If presente, this icon 
     will be drawed into the button
     */
    @IBInspectable var svgIconUrl: NSURL?
    
    /**
     The shape's color
     */
    @IBInspectable var fillColor: UIColor?
    
    
    //It was necessary to use this workarround to fill the layers with the segment color
    //https://github.com/SVGKit/SVGKit/issues/98
    func changeFillColorRecursively(sublayers: [CALayer], color: UIColor) {
        for layer in sublayers {
            
            if let l = layer as? CAShapeLayer {
                l.fillColor = color.CGColor
            }
            
            if let l: CALayer = layer, sub = l.sublayers {
                changeFillColorRecursively(sub, color: color)
            }
            
        }
    }
    
    // Overriding for drawing the SVG icons into the buttons.
    override func drawRect(rect: CGRect) {
        
        if let svgIconUrl = svgIconUrl {
            
            let request = NSURLRequest(URL: svgIconUrl)
            
            //This is asynchronous. When the download completes, the sgv image will be converted and drawed into the button
            let getSvgResourceTask = NSURLSession.sharedSession().dataTaskWithRequest(request){ data, response, error in
                
                if let svgData = data as NSData? {
                    
                    let svgSource = SVGKSource(inputSteam: NSInputStream(data: svgData))
                    let svgParsed = SVGKParser.parseSourceUsingDefaultSVGKParser(svgSource)
                    let svgImage = SVGKImage(parsedSVG: svgParsed, fromSource: svgSource)
                    
                    //Fill the SVG sublayers with the segment color
                    let svgImageView = SVGKLayeredImageView(SVGKImage: svgImage)
                    let layer = svgImageView.layer
                    self.changeFillColorRecursively(layer.sublayers!, color: self.fillColor!)

                    if let image = svgImage.UIImage {
                        
                        //Creates a context with the same size of the button's frame
                        UIGraphicsBeginImageContextWithOptions(CGSize(width: rect.size.width, height: rect.size.height), false, 0)
                        
                        //Get the contexts that we just created
                        let context = UIGraphicsGetCurrentContext()
                        
                        //Setting the paths and configs.
                        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
                        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
    
                        //Draw the image in the button's rect
                        image.drawInRect(rect)
                        
                        //Tell the context to draw
                        CGContextDrawPath(context, .FillStroke)
                        
                        //Get the image drawed into the context
                        let img = UIGraphicsGetImageFromCurrentImageContext()
                        
                        //Ends the context
                        UIGraphicsEndImageContext()
                        
                        //Sets the image into the buttom asynchronously
                        dispatch_async(dispatch_get_main_queue(), {
                            self.setImage(img, forState: .Normal)
                        });
                    }
                    

                }
            }
            
            getSvgResourceTask.resume()
            
        }

    }
    

}