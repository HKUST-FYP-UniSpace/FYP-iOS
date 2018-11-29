//
//  ColorTests.swift
//  UniSpaceTests
//
//  Created by KiKan Ng on 29/11/2018.
//  Copyright © 2018 KiKan Ng. All rights reserved.
//

import XCTest
@testable import UniSpace

class ColorTests: XCTestCase {

    func testColor() {
        let hexGenColor = UIColor.init(hex: Int("0abab5", radix: 16)!, a: 1.0)
        let rgbGenColor = UIColor.init(r: 10, g: 186, b: 181, a: 1.0)
        let color = UIColor.init(red: 10/255, green: 186/255, blue: 181/255, alpha: 1.0)
        XCTAssertEqual(hexGenColor, color)
        XCTAssertEqual(rgbGenColor, color)
    }

}
