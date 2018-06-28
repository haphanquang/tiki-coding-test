//
//  TikiTweetsTests.swift
//  TikiTweetsTests
//
//  Created by Phan Quang Ha on 6/28/18.
//  Copyright © 2018 Phan Quang Ha. All rights reserved.
//

import XCTest
@testable import TikiTweets

class TikiTweetsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample1() {
        // two tweets
        let text = "The quick brown fox jumps over the lazy dog The quick brown fox jumps over the lazy dog"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, ["1/2 The quick brown fox jumps over the lazy dog", "2/2 The quick brown fox jumps over the lazy dog"])
    }
    
    func testExample2() {
        //one tweet
        let text = "The quick brown fox jumps over the lazy dog"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, ["The quick brown fox jumps over the lazy dog"])
    }
    
    func testExample3() {
        //one tweet exact 50 char
        let text = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, ["Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"])
    }
    
    func testExample4() {
        //one string over 50 char
        let text = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, [])
    }
    
    func testExample5() {
        //two strings over 50 chars
        let text = "Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, [])
    }
    
    func testExample6() {
        //one over 50 chars one < 50 chars
        let text = "Aaaaaaaaaaaaaaaaaaaaaaaaa1aaaaaaaaaaaaaaaaaaaaaaaaaaaa Aaaaaaaaaaaaaaaaaaaaaa2aaaaaaaa"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, ["Aaaaaaaaaaaaaaaaaaaaaaa2aaaaaaaa"])
    }
    
    func testExample7() {
        //one < 50 chars one over 50 chars
        let text = "Aaaaaaaaaaaaaaaaaaaaaa2aaaaaaaa Aaaaaaaaaaaaaaaaaaaaaaaaa1aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let result = text.toTweets(50)
        
        return XCTAssertEqual(result, ["Aaaaaaaaaaaaaaaaaaaaaaa2aaaaaaaa"])
    }
    
}
