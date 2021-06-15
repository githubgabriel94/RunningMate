//
//  WeatherManager.swift
//  RunningMate
//
//  Created by Gabriel Jimenez on 6/14/21.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely,daily&appid=a550113491332d0fa2754a58899c65c0&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.hourly[0].weather[0].id
            let temp = decodedData.current.temp
            let desc = decodedData.hourly[0].weather[0].description
            let windSpeed = decodedData.current.wind_speed
            let pop = decodedData.hourly[0].pop
            let visibility = decodedData.current.visibility
            let hum = decodedData.current.humidity
            
            let weather = WeatherModel(conditionId: id, temperature: temp, currentDesc: desc, windSpeed: windSpeed, chancePrec: pop, visibility: visibility, humidity: hum)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
