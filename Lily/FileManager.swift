//
//  FileManager.swift
//  Lily
//
//  Created by kukushi on 9/7/14.
//  Copyright (c) 2014 kukushi. All rights reserved.
//

import Foundation

class FileManager {
    
    class func path(filename: String) -> String {
        let fileManager = NSFileManager.defaultManager()
        let basicURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
        return basicURL.path! + "/\(filename)"
    }
    
    class func create(filename: String) throws {
        let filePath = path(filename)
        if !fileExistsAtDirectory(filePath) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(filePath, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error as NSError {
                throw error
            }
        }
    }
    
    class func write(data: NSData, filename: String) -> Bool {
        let filePath = path(filename)
        return data.writeToFile(filePath, atomically: true)
    }
    
    class func write(object: AnyObject, filename: String) -> Bool {
        let data = NSKeyedArchiver.archivedDataWithRootObject(object)
        return write(data, filename: filename)
    }
    
    class func fileExistsAtDirectory(filename: String) -> Bool {
        let filePath = path(filename)
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    class func removeFileAtDirectory(filename: String) -> Bool {
        let filePath = path(filename)
        do {
            try NSFileManager.defaultManager().removeItemAtPath(filePath)
        } catch _ {
            return false
        }
        return true
    }
    
    class func itemsAtDirectory(directoryName: String) -> [AnyObject]? {
        let filePath = path(directoryName)
        let URL = NSURL.fileURLWithPath(filePath)
        let fileManager = NSFileManager.defaultManager()
        
        do {
            let contents = try fileManager.contentsOfDirectoryAtURL(URL, includingPropertiesForKeys: [String](), options: .SkipsSubdirectoryDescendants)
            
            var items = [AnyObject]()
            for url in contents {
                do {
                    let data = try NSData(contentsOfURL: url, options: .DataReadingMappedIfSafe)
                    let obj: AnyObject! = NSKeyedUnarchiver.unarchiveObjectWithData(data)
                    items.append(obj)
                } catch let error {
                    print(error)
                    return nil
                }
                return items
            }
            return items
        } catch let error {
            print(error)
            return nil
        }
    }
    
    class func deleteFile(filename: String) throws {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.removeItemAtPath(filename)
        }
        catch let error as NSError {
            throw error
        }
    }
}