//
//  WeatherParser.swift
//  Weather
//
//  Created by Margarita Slesareva on 15.07.2023.
//

import Foundation

final class WeatherParser: Parser {

    typealias Object = Weather
    
    func parseData(data: Data) -> Weather? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard let jsonDictionary = jsonObject as? [String: Any] else {
                return nil
            }
            
            guard let weatherArray = jsonDictionary["weather"] as? [[String: Any]] else {
                return nil
            }
            
            guard let description = weatherArray.first?["description"] as? String else {
                return nil
            }
            
            guard let mainDictionary = jsonDictionary["main"] as? [String: Any] else {
                return nil
            }
            
            guard let temperature = mainDictionary["temp"] as? Double else {
                return nil
            }
            
            guard let feelsLikeTemperature = mainDictionary["feels_like"] as? Double else {
                return nil
            }
            
            guard let minTemperature = mainDictionary["temp_min"] as? Double else {
                return nil
            }
            
            guard let maxTemperature = mainDictionary["temp_max"] as? Double else {
                return nil
            }
            
            guard let pressure = mainDictionary["pressure"] as? Double else {
                return nil
            }
            
            return Weather(
                description: description,
                temperature: temperature,
                feelsLikeTemperature: feelsLikeTemperature,
                minTemperature: minTemperature,
                maxTemperature: maxTemperature,
                pressure: pressure
            )
        } catch {
            print("! JSON parsing error: " + error.localizedDescription)
            return nil
        }
    }
}
