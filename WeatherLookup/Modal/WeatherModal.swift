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


struct WeatherData : Codable, Equatable {
    
    let main : String?
    let description : String?

    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
    }
    
}

extension WeatherObject {
    
    public var temparature : String {
        return String(main?.temp ?? 0)
    }
    
    public var humidity : String {
        return String(main?.humidity ?? 0)
    }
}
