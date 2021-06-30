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
    case invalidInputDataError
    case parsingFailedError(error: String)
    
    var errorMsg: String {
        
        switch self {
        case .invaidUrlError:
            return "Invalid URL"
        case .invalidDataError:
            return "Invalid Data"
        case .invalidInputDataError:
            return "Invalid input Data"
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
        //return "https://api.openweathermap.org/data/2.5/forecast?lat=0"  + "&lon=0"  + "&appid=" + apiKey + "&units=" + unitType

    }
    
    func fetchWeatherForecastInfo(latitude : String, longitude : String,  completionHandler: @escaping (Weather?, ParsingError?) -> Void) {
        
        let urlString = getURLEndPath(latitude: latitude, longitude: longitude)
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
            if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                do {
                    let addressObj = try JSONDecoder().decode(Weather.self, from: data)
                    completionHandler(addressObj, nil)
                } catch let error {
                    print(error)
                    completionHandler(nil, .parsingFailedError(error: error.localizedDescription))
                }
                
            } else {
                let strResponse = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?
                print("Response String :\(String(describing: strResponse))")
                let dict =  strResponse?.convertToDictionary()
                completionHandler(nil, .parsingFailedError(error: dict?["message"] as? String ?? ""))
            }
            
        }.resume()
    }
}

