//
//  WeatherData.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 6/13/21.
//

import Foundation

struct WeatherData: Codable {
    let current: Current
    let hourly: [Hourly]
}

struct Current: Codable {
    let temp: Double
    let humidity: Int
    let visibility: Int
    let wind_speed: Double
}

struct Hourly: Codable {
    let weather: [Weather]
    let pop: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
