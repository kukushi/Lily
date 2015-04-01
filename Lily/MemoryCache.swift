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
        
        public init() {
            
        }
        
        // MARK: Subscript
        
        // suscript with context and key
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
        
        // subscript with key
        
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
        
        public func removeAll() {
            for cache in caches.values {
                cache.removeAll()
            }
        }
    }
}