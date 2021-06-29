//
//  NetworkDataManager.swift
//  WeatherLookup
//
//  Created by Chenna on 6/28/21.
//

import Foundation
import CoreData

enum ParsingError: Error {
    case invaidUrlError
    case invalidDataError
    case parsingFailedError(error: String)
    
    var errorMsg: String {
        
        switch self {
        case .invaidUrlError:
            return "Invalid URL"
        case .invalidDataError:
            return "Invalid Data"
        case let .parsingFailedError(error: error):
            return "\(error)"
        }
    }
}

class DataManager {
    
    let apiKey = "fae7190d7e6433ec3a45285ffcf55c86"
    var unitType = "metric"
    
    private func getURLEndPath(latitude : String, longitude : String) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=" + latitude + "&lon=" + longitude + "&appid=" + apiKey + "&units=" + unitType
    }
    
    func fetchWeatherForecastInfo(location : LocationObject,  completionHandler: @escaping (Weather?, ParsingError?) -> Void) {
        
        let urlString = getURLEndPath(latitude: location.locationLatitude ?? "", longitude: location.locationLongitude ?? "")
        print(urlString)
        guard let addressURL = URL(string: urlString) else {
            completionHandler(nil, .invaidUrlError)
            return
        }
        URLSession.shared.dataTask(with: addressURL) {(data, response, error) in
            guard error == nil  || data != nil else {
                completionHandler(nil, .invalidDataError)
                return
            }
            guard let data = data else {
                completionHandler(nil, .invalidDataError)
                return
            }
            do {
                let addressObj = try JSONDecoder().decode(Weather.self, from: data)
                completionHandler(addressObj, nil)
            } catch let error {
                print(error)
                completionHandler(nil, .parsingFailedError(error: error.localizedDescription))
            }
        }.resume()
    }
}


