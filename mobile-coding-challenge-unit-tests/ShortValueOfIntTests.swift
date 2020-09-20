//
//  ShortValueOfIntTests.swift
//  mobile-coding-challenge-unit-tests
//
//  Created by Mobile on 9/20/20.
//  Copyright © 2020 Zakariae. All rights reserved.
//

import XCTest

class ShortValueOfIntTests: XCTestCase {
    
    func testForIsShortValueOfIntCorrect(){
        
        XCTAssertEqual(100.shortValue, "100")
        XCTAssertEqual((-800).shortValue, "-800")
        XCTAssertEqual(8000.shortValue, "8.0K")
        XCTAssertEqual(2000000.shortValue, "2.0M")
        XCTAssertEqual(100000000000.shortValue, "+100...")
        
    }

}
