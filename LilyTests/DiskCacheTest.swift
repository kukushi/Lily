//
//  DiskCacheTest.swift
//  Lily
//
//  Created by kukushi on 4/13/15.
//  Copyright (c) 2015 kukushi. All rights reserved.
//

import XCTest
@testable import Lily

class Object: NSObject, NSCoding {
    var lily = "poi"
    
    override init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        lily = aDecoder.decodeObjectForKey("lily") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(lily, forKey: "lily")
    }
}

class DiskCacheTest: XCTestCase {
    
    var diskCache: Lily.DiskCache!
    
    // MARK: Setup

    override func setUp() {
        super.setUp()
        diskCache = Lily.DiskCache()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCacheInt() {
        diskCache["1"] = 1
        
        XCTAssert(self.diskCache["1"].int == 1)
        
        let expectation = expectationWithDescription("Wait for clearing disk cache")
        self.diskCache["1"].fetch { object in
            let valid = (object as! Int == 1) && (FileManager.fileExistsAtDirectory("Default/1"))
            XCTAssertTrue(valid)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler:nil)
    }
    
    func testCacheDictionary() {
        let object = Object()
        let dict = ["object": object]
        diskCache["objectdictionary"] = dict
        
        let expectation = expectationWithDescription("Wait for clearing disk cache")
        self.diskCache["objectdictionary"].fetch { object in
            let isObjectCorrect = (object as! [String: Object] == dict)
            let isFileExist = FileManager.fileExistsAtDirectory("Default/objectdictionary")
            XCTAssertTrue(isObjectCorrect && isFileExist)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler:nil)
    }
}
