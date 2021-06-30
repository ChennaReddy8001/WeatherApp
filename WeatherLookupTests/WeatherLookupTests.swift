//
//  WeatherLookupTests.swift
//  WeatherLookupTests
//
//  Created by Chenna on 6/26/21.
//

import XCTest
@testable import WeatherLookup

class WeatherLookupTests: XCTestCase {

    func testTitleOfHomeScreen(){
        
      //  let text = "Please add a location by clicking on the + symbol"
        let homeVC = HomeVC()
        XCTAssertEqual(homeVC.navigatonBarTitle, "Home")
    }
}
