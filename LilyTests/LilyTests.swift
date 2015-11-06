//
//  LilyTests.swift
//  LilyTests
//
//  Created by kukushi on 3/27/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import UIKit
import XCTest
import Lily

class LilyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        
        MemoryCache["1"] = 1
        MemoryCache["1", "Another"] = 2
        
        XCTAssert(MemoryCache["1"].int == 1, "1")
        XCTAssert(MemoryCache["1", "Another"].int == 2, "2")
    }
}
