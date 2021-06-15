//
//  WeatherModel.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 6/13/21.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let temperature: Double
    let currentDesc: String
    let windSpeed: Double
    let chancePrec: Double
    let visibility: Int
    let humidity: Int
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var windSpeedString: String{
        return String(format: "%.1f", windSpeed)
    }
    
    var popString: String{
        let pop = chancePrec*100
        return String(pop)
    }
    
    var visibilityString: String{
        return String(visibility)
    }
    
    var humidityString: String{
        return String(humidity)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
