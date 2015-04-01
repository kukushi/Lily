//
//  Lily.swift
//  Lily
//
//  Created by kukushi on 3/27/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation

let MemoryCache = Lily.shared.memoryCache
let DiskCache = Lily.shared.diskCache
let QuickCache = Lily.shared.quickCache


private let instance = Lily()

public class Lily {
    class var shared: Lily {
        return instance
    }
    
    lazy var memoryCache = NSCache()
    lazy var diskCache = DiskCache()
    lazy var quickCache = QuickCache()
    
    // MARK:
    
    init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "memoryWarningReceived", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    func memoryWarningReceived() {
        memoryCache.removeAll()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension Lily {
    class DiskCache {
        var cache = NSCache()
    
    }
}


extension Lily {
    class QuickCache {
        var cache = NSCache()
        
        // MARK:  Initialization
        
        init() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "cacheToDisk", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        }
        
        deinit {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        
        func cacheToDisk() {
            for key in cache.allKeys {
                if let object: AnyObject = cache[key] {
                    let data = NSKeyedArchiver.archivedDataWithRootObject(object)
                    FileManager.write(data, filename: key)
                }
            }
        }
        
        // MARK: 
        
        subscript(key: String) -> CacheProxy {
            return CacheProxy(key, cache)
        }
        
        subscript(key: String) -> AnyObject? {
            get {
                return self[key]
            }
            set {
                cache[key] = newValue
            }
        }
    }
}