//
//  MemoryCache.swift
//  Lily
//
//  Created by kukushi on 3/31/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation


public extension Lily {
    public class MemoryCache {
        
    lazy var caches: [String: NSCache] = ["Default": NSCache()]
        
        // MARK: Initialization
        
        public init() {
            
        }
        
        // MARK: Subscript
        
        /**
        subscript with context and key
        
        - parameter key:     the key of cache
        - parameter context: the context of cache
        
        - returns: a cache proxy with named key and context. You don't have to use
        it directly.
        */
        public subscript(key: String, context: String) -> CacheProxy {
            if caches[context] == nil {
                caches[context] = NSCache()
            }
            let cache = caches[context]
            return CacheProxy(key, cache!)
        }
        
        
        public subscript(key: String, context: String) -> AnyObject? {
            get {
                return self[key, context]
            }
            
            set {
                if caches[context] == nil {
                    caches[context] = NSCache()
                }
                let cache = caches[context]
                cache![key] = newValue
            }
        }
        
        /**
        subscript with key only
        
        - parameter key: the key of cache
        
        - returns: a cache proxy with named key and default context. You don't have to use
        it directly
        */
        public subscript(key: String) -> CacheProxy {
            return self[key, "Default"]
        }
        
        public subscript(key: String) -> AnyObject? {
            get {
                return self[key]
            }
            
            set {
                let cache = caches["Default"]
                cache![key] = newValue
            }
        }
        
        // MARK:
        
        /**
        Remove all items in cache.
        */
        public func removeAll() {
            for cache in caches.values {
                cache.removeAll()
            }
        }
    }
}