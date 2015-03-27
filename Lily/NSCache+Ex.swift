//
//  NSCacheExtension.swift
//  SwifyCache
//
//  Created by kukushi on 3/24/15.
//  Copyright (c) 2015 Xing He. All rights reserved.
//

import Foundation


public extension NSCache {
    // Inner proxy class
    class CacheProxy {
        private let key: String
        private let cache: NSCache
        
        init (_ key: String, _ cache: NSCache) {
            self.key = key
            self.cache = cache
        }
        
        func remove() {
            cache.removeObjectForKey(key)
        }
        
        var object: AnyObject? {
            return cache.objectForKey(key)
        }
        
        var string: String {
            return (object as? String) ?? ""
        }
        
        var data: NSData {
            return (object as? NSData) ?? NSData()
        }
        
        var number: NSNumber? {
            return object as? NSNumber
        }
        
        var value: NSValue? {
            return object as? NSValue
        }
        
        var bool: Bool {
            return (object as? Bool) ?? false
        }
        
        var double: Double {
            return number?.doubleValue ?? 0
        }
        
        var float: Float {
            return number?.floatValue ?? 0
        }
        
        var int: Int {
            return number?.integerValue ?? 0
        }
    }
    
    subscript(key: String) -> CacheProxy {
        return CacheProxy(key, self)
    }
    
    subscript(key: String) -> AnyObject? {
        get {
            return self[key]
        }
        set {
            if newValue != nil {
                setObject(newValue!, forKey: key)
            }
        }
    }
    
    public func removeAll() {
        removeAllObjects()
    }
}