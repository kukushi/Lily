//
//  FileManager.swift
//  BangumiKit
//
//  Created by kukushi on 9/7/14.
//  Copyright (c) 2014 kukushi. All rights reserved.
//

import Foundation

class FileManager {
    
    class func path(#filename: String) -> String {
        let fileManager = NSFileManager.defaultManager()
        let basicURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first as! NSURL
        return basicURL.path! + "/\(filename)"
    }
    
    class func write(data: NSData, filename: String) -> Bool {
        let filePath = path(filename: filename)
        return data.writeToFile(filePath, atomically: true)
    }
    
    class func write(object: AnyObject, filename: String) -> Bool {
        let data = NSKeyedArchiver.archivedDataWithRootObject(object)
        return write(data, filename: filename)
    }
    
    class func fileExistsAtDirectory(filename: String) -> Bool {
        let filePath = path(filename: filename)
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func removeFileAtDirectory(filename: String) -> Bool {
        let filePath = path(filename: filename)
        return NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil)
    }
    
    class func itemsAtDirectory(directoryName: String) -> [AnyObject]? {
        let filePath = path(filename: directoryName)
        if let URL = NSURL.fileURLWithPath(filePath) {
            var error: NSError?
            let fileManager = NSFileManager.defaultManager()
            if let contents = fileManager.contentsOfDirectoryAtURL(URL, includingPropertiesForKeys: [AnyObject](), options: .SkipsSubdirectoryDescendants, error: &error) as? [NSURL] {
                if let theError = error {
                    var items = [AnyObject]()
                    for url in contents {
                        let data = NSData(contentsOfURL: url, options: .DataReadingMappedIfSafe, error: &error)
                        if let theError = error {
                            let obj: AnyObject! = NSKeyedUnarchiver.unarchiveObjectWithData(data!)
                            items.append(obj)
                        }
                    }
                    return items
                }
            }
        }
        return nil
    }
    
    class func deleteFile(filename: String, error: NSErrorPointer) -> Bool {
        let fileManager = NSFileManager.defaultManager()
        let filePath = path(filename: filename)
        if !fileManager.removeItemAtPath(filename, error: error) {
            println("\(error)")
            return true
        }
        return false
    }
}