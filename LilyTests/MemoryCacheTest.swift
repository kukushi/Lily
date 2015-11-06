//
//  MemoryCacheTest.swift
//  Lily
//
//  Created by kukushi on 4/1/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit
import XCTest
import Lily

class MemoryCacheTest: XCTestCase {
    
    var memoryCache: Lily.MemoryCache!

    // MARK: Setup
    
    override func setUp() {
        super.setUp()
        memoryCache = Lily.MemoryCache()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK:

    func testCacheInt() {
        
        memoryCache["1"] = 1
        XCTAssert(memoryCache["1"].int == 1)
        
        XCTAssert(memoryCache["2"].int == nil)
        XCTAssert(memoryCache["2"].intValue == 0)
        
        memoryCache["1"].remove()
        XCTAssert(memoryCache["1"].int == nil)
    }
    
    func testCacheBool() {
        
        memoryCache["True"] = true
        XCTAssert(memoryCache["True"].bool == true, "True Storage Pass")
        
        XCTAssert(memoryCache["false"].bool == nil, "Unexsit Storage Pass")
        XCTAssert(memoryCache["false"].boolValue == false, "Unexsit Storage Default Value Pass")
        
        memoryCache["True"].remove()
        XCTAssert(memoryCache["True"].bool == nil, "Remove Int Storage Pass")
    }
    
    func testDoubleStorageExample() {
        
        memoryCache["1.0"] = 1.0
        XCTAssert(memoryCache["1.0"].double == 1.0, "True Storage Pass")
        
        XCTAssert(memoryCache["2.0"].double == nil, "Unexsit Storage Pass")
        XCTAssert(memoryCache["2.0"].doubleValue == 0, "Unexsit Storage Default Value Pass")
        
        memoryCache["1.0"].remove()
        XCTAssert(memoryCache["1.0"].bool == nil, "Remove Int Storage Pass")
    }
}
