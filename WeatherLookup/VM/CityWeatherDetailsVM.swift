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
        
        dataManager.fetchWeatherForecastInfo(latitude: selectedLocation.locationLatitude ?? "" , longitude: selectedLocation.locationLongitude ?? "") { [weak self](weatherInfo, error) in
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
    
    func getTitleForHeaderInSection(section: Int) -> String {
        if dataArray.count > 0 {
            let array = dataArray[section] as [WeatherObject]
            if array.count > 0 {
                let weatherObject = array[0] as WeatherObject
                return weatherObject.dateInDateFormat.asString(style: .full)
            }
        }
        return ""
    }
    
    func numberOfrowsInSection(section: Int) -> Int {
        if dataArray.count > 0 {
            let array = dataArray[section] as [WeatherObject]
            return array.count
        }else{
            return 1
        }
    }
    
    func getWeatherObjectAtIndexPath(indexPath: IndexPath) -> WeatherObject?{
        if dataArray.count > indexPath.section {
            let array = dataArray[indexPath.section] as [WeatherObject]
            if array.count > indexPath.row {
                return  array[indexPath.row]
            }
            return nil
        }
        return nil
    }
}


   
