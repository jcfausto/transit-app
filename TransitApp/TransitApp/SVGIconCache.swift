//
//  SvgIconCache.swift
//  TransitApp
//
//  Created by Julio Cesar Fausto on 28/02/16.
//  Copyright © 2016 Julio Cesar Fausto. All rights reserved.
//

import Foundation
import SVGKit

/**
 This class stores the SVG icons loaded in order to 
 avoid unnecessary network usage. It will consume a litle bit
 more space but will enhance the UX
*/
class SVGIconCache {
    
    /**
     In order to store an SVG to the chace, provide the SGV itself and 
     a related fileName that later could be used to retrieve the SVG
     */
    func saveSVG(svgData: NSData, fileName: String) {
        let filePath = getFilePathForKey(fileName)

        do {
            try svgData.writeToFile(filePath, options: .AtomicWrite)
        } catch {
            print(error)
        }

    }
    
    /**
     Retrieve and SVGIMage by its fileName from cache if it exists
     */
    func retrieveSVG(fileName: String) -> NSData? {
        let filePath = getFilePathForKey(fileName)
        let data = NSData(contentsOfFile: filePath)
        return data
    }
    
    /**
     Assemble the corret file path
     */
    func getFilePathForKey(key: String) -> String {
        return getDocumentsDirectory().stringByAppendingPathComponent(key)
    }
    
    /**
     Gets the document directory where the cache will reside
     */
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
}
