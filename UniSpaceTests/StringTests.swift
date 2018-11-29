//
//  StringTests.swift
//  UniSpaceTests
//
//  Created by KiKan Ng on 29/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import XCTest
@testable import UniSpace

class StringTests: XCTestCase {

    func testAreEmail() {
        XCTAssertTrue("123@example.com".areEmail())
        XCTAssertFalse("123456789".areEmail())
        XCTAssertFalse("123@abc".areEmail())
    }
    
    func testAreNumbers() {
        XCTAssertTrue("123".areNumbers())
        XCTAssertTrue("-123".areNumbers())
        XCTAssertTrue("0.5".areNumbers())
        XCTAssertFalse("-4a.5".areNumbers())
    }
    
    func testSubscript() {
        XCTAssertEqual("123"[1], "2")
        XCTAssertEqual("😂😏🙈"[1], "😏")
        XCTAssertNotEqual("abc"[1], "a")
    }
    
    func testCapitalizingFirstLetter() {
        XCTAssertEqual("abc".capitalizingFirstLetter(), "Abc")
        XCTAssertEqual("123".capitalizingFirstLetter(), "123")
        XCTAssertNotEqual("def".capitalizingFirstLetter(), "DEF")
    }
    
    func testCapitalizeFirstLetter() {
        var testString = "qwerty"
        testString.capitalizeFirstLetter()
        XCTAssertEqual(testString, "Qwerty")
    }
    
    func testContainsEmoji() {
        XCTAssertTrue("abc😂😏🙈".containsEmoji)
        XCTAssertFalse("abc".containsEmoji)
    }
    
    func testRemoveEmoji() {
        XCTAssertEqual("abc😂😏🙈".removeEmoji, "abc")
        XCTAssertEqual("a😂c😏f🙈r".removeEmoji, "acfr")
        XCTAssertEqual("abc".removeEmoji, "abc")
    }

}
