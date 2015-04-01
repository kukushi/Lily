//
//  QuickCache.swift
//  Lily
//
//  Created by kukushi on 4/1/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation


public extension Lily {
    public class QuickCache {
        private var memoryCache = Lily.MemoryCache()
        
        // MARK: Initialization
        
        init() {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "cacheToDisk", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        }
        
        deinit {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        
        // MARK: Cache
        
        func cacheToDisk() {
            for (_, (_, cache)) in enumerate(memoryCache.caches) {
                for key in cache.allKeys {
                    if let object: AnyObject = cache[key] {
                        let data = NSKeyedArchiver.archivedDataWithRootObject(object)
                        FileManager.write(data, filename: key)
                    }
                }
            }
        }
        
        // MARK: Subscript with Key & Context
        
        public subscript(key: String, context: String) -> CacheProxy {
            return memoryCache[key, context]
        }
        
        public subscript(key: String, context: String) -> AnyObject? {
            get {
                return self[key, context]
            }
            set {
                memoryCache[key, context] = newValue
            }
        }
        
        // MARK: Subscript with Key only
        
        public subscript(key: String) -> CacheProxy {
            return memoryCache[key]
        }
        
        public subscript(key: String) -> AnyObject? {
            get {
                return self[key]
            }
            set {
                memoryCache[key] = newValue
            }
        }
    }
}