//
//  Lily.swift
//  Lily
//
//  Created by kukushi on 3/27/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import Foundation

public let MemoryCache = Lily.shared.memoryCache
public let DiskCache = Lily.shared.diskCache
public let QuickCache = Lily.shared.quickCache


// MARK: Lily Class

private let instance = Lily()

public class Lily {
    class var shared: Lily {
        return instance
    }
    
    lazy var memoryCache = MemoryCache()
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