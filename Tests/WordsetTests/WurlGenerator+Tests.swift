//
//  WurlGenerator+Tests.swift
//
//
//  Created by David Evans on 23/09/2019.
//

import XCTest
import class Foundation.Bundle
@testable import Wordset

final class WurlGenerator_Tests: XCTestCase {
    
    // test that `.new` creates a 3-word WURL
    func testNew() {
        let wurl = WurlGenerator.new
        let words = wurl.split(separator: "-").map { String($0) }
        XCTAssertEqual(words.count, 3)
        XCTAssertTrue(Wordsets.set1.contains(words[0]))
        XCTAssertTrue(Wordsets.set2.contains(words[1]))
        XCTAssertTrue(Wordsets.set3.contains(words[2]))
    }

    // test that we override one word and convert it to 3
    func testCreate_1() {
        let wurl = WurlGenerator.create(wordCount: 1)
        let words = wurl.split(separator: "-").map { String($0) }
        XCTAssertEqual(words.count, 3)
        XCTAssertTrue(Wordsets.set1.contains(words[0]))
        XCTAssertTrue(Wordsets.set2.contains(words[1]))
        XCTAssertTrue(Wordsets.set3.contains(words[2]))
    }
    
    // test that we can create a new WURL of arbitrary length
    func testCreate_10() {
        let wurl = WurlGenerator.create(wordCount: 10)
        let words = wurl.split(separator: "-").map { String($0) }
        XCTAssertEqual(words.count, 10)
        XCTAssertTrue(Wordsets.set1.contains(words[0]))
        for i in 1...8 {
            XCTAssertTrue(Wordsets.set2.contains(words[i]))
        }
        XCTAssertTrue(Wordsets.set3.contains(words[9]))
    }
    
    // test creating lots of times to ensure we don't hit a range error
    func testCreate_lots() {
        for _ in 0...10_000 {
            _ = WurlGenerator.new
        }
    }

}
