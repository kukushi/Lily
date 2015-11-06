//
//  FileManager.swift
//  Lily
//
//  Created by kukushi on 9/7/14.
//  Copyright (c) 2014 kukushi. All rights reserved.
//

import Foundation

class FileManager {
    /**
     Compose a path whih the given file name in the Document Directory
     
     - parameter filename: the file name
     
     - returns: the path
     */
    class func path(filename: String) -> String {
        let fileManager = NSFileManager.defaultManager()
        let basicURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains:.UserDomainMask).first!
        return basicURL.path! + "/\(filename)"
    }
    
    /**
     Create a file or folder with the given file name under the Document Directory
     
     - parameter filename: the file name
     
     - throws: error when creating file
     */
    class func create(filename: String) throws {
        let filePath = path(filename)
        if !fileExistsAtDirectory(filePath) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(filePath, withIntermediateDirectories: false, attributes: nil)
            }
            catch let error {
                throw error
            }
        }
    }
    
    /**
     Write data to the the given file name under the Document Directory
     
     - parameter data:     data to write
     - parameter filename: the file name
     
     - returns: A Boolen value indicate success
     */
    class func write(data: NSData, filename: String) -> Bool {
        let filePath = path(filename)
        return data.writeToFile(filePath, atomically: true)
    }
    
    /**
     Write the object to the the given file name under the *Document Directory*
     
     - parameter object:   the object to write, should support NSCoding
     - parameter filename: the file name
     
     - returns: A Boolen value indicate success
     */
    class func write(object: NSCoding, filename: String) -> Bool {
        let data = NSKeyedArchiver.archivedDataWithRootObject(object)
        return write(data, filename: filename)
    }
    
    /**
     Indicate whether there is a file in the give name in the Document Directory
     
     - parameter filename: the file name
     
     - returns: Yes if there is a file in the given path, otherwise No.
     */
    class func fileExistsAtDirectory(filename: String) -> Bool {
        let filePath = path(filename)
        return NSFileManager.defaultManager().fileExistsAtPath(filePath)
    }
    
    
    /**
     Remove file from the give path
     
     - parameter filename: the file name
     
     - throws: error
     */
    class func removeFileAtDirectory(filename: String) throws {
        let filePath = path(filename)
        do {
            try NSFileManager.defaultManager().removeItemAtPath(filePath)
        }
        catch let error as NSError {
            throw error
        }
    }
    
    class func itemsAtDirectory(directoryName: String) throws -> [AnyObject]? {
        let filePath = path(directoryName)
        let URL = NSURL.fileURLWithPath(filePath)
        let fileManager = NSFileManager.defaultManager()
        
        do {
            let contents = try fileManager.contentsOfDirectoryAtURL(URL, includingPropertiesForKeys: [String](), options: .SkipsSubdirectoryDescendants)
            
            var items = [AnyObject]()
            for url in contents {
                do {
                    let data = try NSData(contentsOfURL: url, options: .DataReadingMappedIfSafe)
                    if let obj = NSKeyedUnarchiver.unarchiveObjectWithData(data) {
                        items.append(obj)
                    }
                }
                catch let error {
                    // Failt to unarchiver content from file
                    print(error)
                }
            }
            return items
        }
        catch let error {
            // Fail to get the folder's content
            throw error
        }
    }
    
    class func deleteFile(filename: String) throws {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.removeItemAtPath(filename)
        }
        catch let error {
            throw error
        }
    }
}