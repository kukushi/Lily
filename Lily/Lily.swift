//
//  Lily.swift
//  Lily
//
//  Created by kukushi on 3/27/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation

/// Some global instance for quick access 
public let MemoryCache = Lily.shared.memoryCache
public let DiskCache = Lily.shared.diskCache
public let QuickCache = Lily.shared.quickCache


// MARK: Lily Main Class

private let instance = Lily()

public class Lily: NSObject {
    class var shared: Lily {
        return instance
    }
    
    lazy var memoryCache = MemoryCache()
    lazy var diskCache = DiskCache()
    lazy var quickCache = QuickCache()
    
    // MARK: Initialization
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "memoryWarningReceived", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK:
    
    func memoryWarningReceived() {
        memoryCache.removeAll()
    }
}