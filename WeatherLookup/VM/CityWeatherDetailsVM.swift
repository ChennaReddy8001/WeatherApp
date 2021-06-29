//
//  CityWeatherDetailsVM.swift
//  WeatherLookup
//
//  Created by Chenna on 6/28/21.
//

import Foundation


class CityWeatherDetailsVM {
    
    var dataManager = DataManager()
    var selectedLocation : LocationObject!
    var dataArray: [[WeatherObject]] = [[]]
        
    func getWeatherInfoForTheSelectedLocation(completionHandler: @escaping () -> Void){
        
        dataManager.fetchWeatherForecastInfo(location: selectedLocation) { [weak self](weatherInfo, error) in
            guard let weahterInfo = weatherInfo , error == nil else {
                completionHandler()
                return
            }
            let dataArray = weahterInfo.list ?? []
            self?.dataArray = dataArray.groupSort(byDate: { $0.dateInDateFormat })
            completionHandler()
            
        }
    }
    
    convenience init(with location : LocationObject) {
        self.init()
        selectedLocation = location
    }
}


   
