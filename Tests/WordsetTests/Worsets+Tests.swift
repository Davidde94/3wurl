//
//  Worsets+Tests.swift
//
//
//  Created by David Evans on 23/09/2019.
//

import XCTest
import class Foundation.Bundle
@testable import Wordset

final class Wordset_Tests: XCTestCase {
    
    func testWordsExist() throws {
        XCTAssertTrue(Wordsets.set1.count > 0)
        XCTAssertTrue(Wordsets.set2.count > 0)
        XCTAssertTrue(Wordsets.set3.count > 0)
    }


}
