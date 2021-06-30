//
//  SettingsVCTests.swift
//  WeatherLookupTests
//
//  Created by Chenna on 6/30/21.
//

import XCTest
@testable import WeatherLookup

class SettingsVCTests: XCTestCase {

    let settingsVC = SettingsVC()
    
    func testTitleOfSettingsScreen(){
        
        XCTAssertEqual(settingsVC.navigatonBarTitle, "Settings")
    }
    
    func testResetConfirmationQuestionText(){
        
        XCTAssertEqual(settingsVC.resetConfirmationQuestionText,  "Are you sure you want to reset all the bookmarked locations?")
    }
    
    func testResetConfirmationMessageText(){
        
        XCTAssertEqual(settingsVC.resetConfirmationMessageText, "All the bookmarked locations have been reset!!")
    }
    
    func testAlertTitleText(){
        
        XCTAssertEqual(settingsVC.alertTitleText,  "WeatherLookup")
    }
    
    func testYesButtonText(){
        
        XCTAssertEqual(settingsVC.yesButtonText,  "Yes")
    }
    
    func testNoButtonText(){
        
        XCTAssertEqual(settingsVC.noButtonText,  "No")
    }
    
    func testOkButtonText(){
        
        XCTAssertEqual(settingsVC.okButtonText,  "OK")
    }
    

}
