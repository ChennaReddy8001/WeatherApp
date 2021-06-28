//
//  WeatherModal.swift
//  WeatherLookup
//
//  Created by Chenna on 6/26/21.
//

import Foundation

import Foundation

struct Weather : Decodable, Equatable {
    let list : [WeatherObject]?
}

struct WeatherObject : Decodable, Equatable {
    let weather : [WeatherData]?
    let main : Main?
    let wind : Wind?
    
    let dt_txt : String
}

struct Main : Decodable, Equatable {
    
    let temp : Float?
    let humidity : Int?
    let feels_like : Float?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case humidity = "humidity"
    }
    
}

struct Wind : Decodable, Equatable {
    
    let speed : Float?
    let deg : Int?
    let gust : Float?

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
    
}


struct WeatherData : Decodable, Equatable {
    
    let main : String?
    let description : String?

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
    
}


extension WeatherObject {
    public var dateString : String { return dt_txt}
    public var dateInDateFormat : Date {return dateString.toDate() ?? Date()}
    public var temparature : String {
        return String(main?.temp ?? 0)
    }
    
    public var humidity : String {
        return String(main?.humidity ?? 0)
    }
    
    public var windInfo : String {
        return String(wind?.speed ?? 0.0)
    }
    
    
    public var rainChances : String {
        
        if weather?.count ?? 0 > 0 {
            if let weather = weather?[0] {
                return weather.main ?? ""
            }
        }
        return ""
        
    }

}
