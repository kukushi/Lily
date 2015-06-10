//
//  DiskCache.swift
//  Lily
//
//  Created by kukushi on 4/1/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation

public extension Lily {
    public class DiskCache {
        var memoryCache = MemoryCache()
        
        public init () {
            
        }
        
        public lazy var cacheQueue : dispatch_queue_t = {
            let queueName = "kukushi.Lily.Cache"
            let cacheQueue = dispatch_queue_create(queueName, nil)
            return cacheQueue
        }()
        
        // subscript with key
        
        public subscript(key: String) -> ValueProxy {
            return self[key, "Default"]
        }
        
        public subscript(key: String) -> AnyObject? {
            get {
                return self[key]
            }
            
            set {
                self[key, "Default"] = newValue
            }
        }
        
        public subscript(key: String, context: String) -> ValueProxy {
            let proxy = ValueProxy(key: key, context: context, cache: memoryCache)
            proxy.cacheQueue = cacheQueue
            return proxy
        }
        
        public subscript(key: String, context: String) -> AnyObject? {
            get {
                return self[key, context]
            }
            set {
                memoryCache[key, context] = newValue
                dispatch_async(cacheQueue, { () -> Void in
                    let data = NSKeyedArchiver.archivedDataWithRootObject(newValue!)
                    if !FileManager.fileExistsAtDirectory("\(context)") {
                        FileManager.create("\(context)")
                    }
                    
                    let writingResult = FileManager.write(data, filename: "\(context)/\(key)")
                })
            }
        }
        
    }
}

public class ValueProxy {
    private let key: String!
    private let context: String!
    private let cache: Lily.MemoryCache!
    var cacheQueue: dispatch_queue_t!
    
    public typealias ValueProxyFetchResult = (object: AnyObject?) -> Void
    public typealias ValueProxyRemoveResult = (success: Bool) -> Void
    
    init(key: String, context: String, cache: Lily.MemoryCache) {
        self.key = key
        self.context = context
        self.cache = cache
    }
    
    public var object: AnyObject? {
        if let object: AnyObject = cache[key, context].object {
            return object
        }
        
        let object = FileManager.itemsAtDirectory("\(context)/\(key)")
        return object
    }
    
    public var string: String? {
        return object as? String
    }
    
    public var stringValue: String {
        return string ?? ""
    }
    
    public var data: NSData? {
        return object as? NSData
    }
    
    public var dataValue: NSData {
        return data ?? NSData()
    }
    
    public var number: NSNumber? {
        return object as? NSNumber
    }
    
    public var value: NSValue? {
        return object as? NSValue
    }
    
    public var bool: Bool? {
        return object as? Bool
    }
    
    public var boolValue: Bool? {
        return bool ?? false
    }
    
    public var double: Double? {
        return number?.doubleValue
    }
    
    public var doubleValue: Double {
        return double ?? 0
    }
    
    public var float: Float? {
        return number?.floatValue
    }
    
    public var floatValue: Float {
        return float ?? 0
    }
    
    public var int: Int? {
        return number?.integerValue
    }
    
    public var intValue: Int {
        return int ?? 0
    }
    
    public func fetch(callback: ValueProxyFetchResult) {
        if let object: AnyObject = cache[key, context].object {
            callback(object: object)
        }
        else {
            dispatch_async(cacheQueue, { () -> Void in
                let path = FileManager.path("\(self.context)/\(self.key)")
                if let data = NSData(contentsOfFile: path), object: AnyObject = NSKeyedUnarchiver.unarchiveObjectWithData(data) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(object: object)
                    })
                }
            })
        }
        
    }
    
    public func remove(callback: ValueProxyRemoveResult? = nil) {
        dispatch_async(cacheQueue, { () -> Void in
            let result = FileManager.removeFileAtDirectory("\(self.context)/\(self.key)")
            callback?(success: result)
        })
    }
}

