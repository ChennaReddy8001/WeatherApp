//
//  DataManagerTests.swift
//  WeatherLookupTests
//
//  Created by Chenna on 6/30/21.
//

import XCTest

@testable import WeatherLookup


class DataManagerTests: XCTestCase {
    
    func testWeatherAPIDataWithInValidData(){
        
        let dataManager = DataManager()
        let dataExpectation = expectation(description: "InValidData")
        dataManager.fetchWeatherForecastInfo(latitude: "", longitude: "")  { (weather, error) in
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            XCTAssertEqual("Nothing to geocode", error?.errorMsg)
            dataExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testWeatherAPIDataWithValidData(){
        
        let dataManager = DataManager()
        let dataExpectation = expectation(description: "ValidData")
        
        dataManager.fetchWeatherForecastInfo(latitude: "12.94", longitude: "77.20")  { (weather, error) in
            XCTAssertNotNil(weather)
            XCTAssertNil(error)
            dataExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
}
