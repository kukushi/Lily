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

let MemoryCache = Lily.MemoryCache()

class LilyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        
        MemoryCache["1"] = 1
        MemoryCache["1", "Another"] = 2
        
        XCTAssert(MemoryCache["1"].int == 1, "1")
        XCTAssert(MemoryCache["1", "Another"].int == 2, "2")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
