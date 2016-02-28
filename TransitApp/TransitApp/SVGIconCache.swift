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
 
 IMPORTANT: Always use the cache in a background thread to avoid blocking
 your main thread
*/
class SVGIconCache {

    // MARK: Properties
    
    /**
     An in memory cache. If the icon was not found in memory the 
     cache will try to retrieve from the disk
    */
    var memoryCache = [SVGCachedObject]()
    
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)

    // MARK: operations
    
    /**
     In order to store an SVG to the chace, provide the SGV itself and 
     a related fileName that later could be used to retrieve the SVG
     */
    func saveSVG(svgData: NSData, fileName: String) {
        let filePath = getFilePathForKey(fileName)

        do {
            try svgData.writeToFile(filePath, options: .AtomicWrite)
            let newCachedObject = SVGCachedObject(data: svgData, fileName: fileName)
            self.memoryCache += [newCachedObject]
        } catch {
            print(error)
        }

    }
    
    /**
     Retrieve and SVGIMage by its fileName from cache if it exists
     */
    func retrieveSVG(fileName: String) -> NSData? {
        
        let cachedData = self.findInMemoryCachedObject(fileName)
        
        if let data = cachedData {
            return data
        } else {
            let filePath = self.getFilePathForKey(fileName)
            //This will blocks the thread until the file is loaded
            return NSData(contentsOfFile: filePath)
        }
  
    }
    
    /**
     Iterates through the cached memory to find for the requested svg
     */
    func findInMemoryCachedObject(fileName: String) -> NSData? {
        var data: NSData?
        
        for obj: SVGCachedObject in memoryCache {
           if obj.fileName == fileName  {
                data = obj.data
            }
        }
        
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
        let documentsDirectory = self.paths[0]
        return documentsDirectory
    }
    
}
