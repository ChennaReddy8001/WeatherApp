//
//  SettingsVM.swift
//  WeatherLookup
//
//  Created by Chenna on 6/30/21.
//

import Foundation
import UIKit

enum UserPreferenceForUnitSystem : String{
    case Metric
    case Imperial
}

let metricsText = "Metric"
let imperialText = "Imperial"

class SettingsVM {
    
    var settingsDataArray : [String] = [String]()
    
    init() {
        settingsDataArray.removeAll()
        settingsDataArray.append(metricsText)
        settingsDataArray.append(imperialText)
    }
    
    func getPreferenceOfUnitSystem() -> String {
        
        var preferedUnitSystem = ""
        if (UserDefaults.standard.bool(forKey: imperialText) == true ) {
            preferedUnitSystem = imperialText
        }else{
            preferedUnitSystem = metricsText
        }
        return preferedUnitSystem
    }
    
    func updateThePreference(isMetric : Bool){
        UserDefaults.standard.setValue(!isMetric, forKey: imperialText)
    }
    
    func setAccessoryTypeForCellWithType(type : String) -> UITableViewCell.AccessoryType {
        let prefered = getPreferenceOfUnitSystem()
        if type == prefered {
            return .checkmark
        }
        return .none
    }
}
