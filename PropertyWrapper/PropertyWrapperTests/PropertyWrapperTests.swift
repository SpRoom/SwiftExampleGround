//
//  PropertyWrapperTests.swift
//  PropertyWrapperTests
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import XCTest
@testable import PropertyWrapper

class PropertyWrapperTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNormalUser() {
        var user = User(firstName: "john", lastName: "appleseed")
        print("firstName: \(user.firstName), lastName: \(user.lastName)")
        user.lastName = "sundell"
        print("firstName: \(user.firstName), lastName: \(user.lastName)")
    }
    
    func testNormalDoc() {
        let doc = Document()
        print(doc.name)
    }
    
    func testDecoder1() throws {
        let flag = FeatureFlags(enabled: false, num: 22)
        print("\n\n\n")
        print("\(flag.isSearchEnabled) -- \(flag.maximumNumberOfNotes)")
        print("\n\n\n")
        
        let json = try JSONEncoder().encode(flag)
        let jsonStr = String(data: json, encoding: .utf8)
        print("\n\n\n")
        print(jsonStr!)
        print("\n\n\n")
    }
    
    func testDecoder2() throws {
        let json = """
        {
        "feature-search": true,
        "experiment-note-limit": 33
        }
        """
        let flag = try JSONDecoder().decode(FeatureFlags.self, from: json.data(using: .utf8)!)
        print("\n\n\n")
        print("\(flag.isSearchEnabled) -- \(flag.maximumNumberOfNotes)")
        print("\n\n\n")
    }
    
    func testToggleVC() {
        let flags: FeatureFlags = FeatureFlags(enabled: true, num: 9)
    
        let searchToggleVC = FlagToggleViewController(flag: flags.$isSearchEnabled)
        print(searchToggleVC)
    }
}
