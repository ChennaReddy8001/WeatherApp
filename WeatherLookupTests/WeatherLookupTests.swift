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
        
        let homeVC = HomeVC()
        XCTAssertEqual(homeVC.navigatonBarTitle, "Home")
    }
    
    func testTitleOfAddLocationScreen(){
        
        let addLocationVC = AddLocationVC()
        XCTAssertEqual(addLocationVC.navigatonBarTitle, "Add New Location")
    }
    
    func testAnnotaitonButtonTitleInAddLocationScreen(){
        
        let addLocationVC = AddLocationVC()
        XCTAssertEqual(addLocationVC.annotationButtonTitle, "Select")
    }
    
    func testResultRegionDistanceInAddLocationScreen(){
        
        let addLocationVC = AddLocationVC()
        XCTAssertEqual(addLocationVC.resultRegionDistance, 6000)
    }
    
    func testPlaceHolderTextInCityDetailsVC(){
        
        let cityDetailsVC = CityDetailsVC()
        XCTAssertEqual(cityDetailsVC.placeHolderTextForNoResultsCase, "No details are available.")
    }
    
    func testSettingsButtonTitleInCityDetailsVC(){
        
        let cityDetailsVC = CityDetailsVC()
        XCTAssertEqual(cityDetailsVC.settingsButtonTitle, "Settings")
    }
    
    func testTitleOfHelpScreen(){
        
        let helpVC = HelpVC()
        XCTAssertEqual(helpVC.navigatonBarTitle, "Help")
    }
    
    func testTitleOfSettingsScreen(){
        
        let settingsVC = SettingsVC()
        XCTAssertEqual(settingsVC.navigatonBarTitle, "Settings")
    }
    
    
}

