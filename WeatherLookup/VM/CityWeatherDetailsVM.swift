//
//  CityWeatherDetailsVM.swift
//  WeatherLookup
//
//  Created by Chenna on 6/28/21.
//

import Foundation


class CityWeatherDetailsVM {
    
    var dataManager = DataManager()
    var selectedLocation : Location!
    var dataArray: [WeatherObject] = []
        
    func getWeatherInfoForTheSelectedLocation(completionHandler: @escaping () -> Void){
        
        dataManager.fetchWeatherForecastInfo(location: selectedLocation) { [weak self](weatherInfo, error) in
            guard let weahterInfo = weatherInfo , error == nil else {
                completionHandler()
                return
            }
            
            self?.dataArray = weahterInfo.list ?? []
            completionHandler()
            
        }
    }
    
    convenience init(with location : Location) {
        self.init()
        selectedLocation = location
    }
}


   
