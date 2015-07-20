//
//  DiskCacheTest.swift
//  Lily
//
//  Created by kukushi on 4/13/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import XCTest
@testable import Lily

class DiskCacheTest: XCTestCase {
    
    var diskCache: Lily.DiskCache!

    override func setUp() {
        super.setUp()
        diskCache = Lily.DiskCache()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        
        diskCache["1"] = 1
        
        XCTAssert(self.diskCache["1"].int == 1, "Direct Read Value Fail")
        
        let expectation = expectationWithDescription("wait for clearing disk cache")
        self.diskCache["1"].fetch { object in
            let valid = (object as! Int == 1) && (FileManager.fileExistsAtDirectory("Default/1"))
            XCTAssert(valid, "fail")
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler:nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
