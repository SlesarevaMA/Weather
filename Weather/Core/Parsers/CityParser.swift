//
//  CityParser.swift
//  Weather
//
//  Created by Margarita Slesareva on 15.07.2023.
//

import Foundation

final class CityParser: Parser {
    
    typealias Object = Coordinates
    
    func parseData(data: Data) -> Coordinates? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard let jsonArray = jsonObject as? [[String: Any]] else {
                return nil
            }
            
            guard let jsonDictionary = jsonArray.first else {
                return nil
            }
            
            guard
                let latitude = jsonDictionary["lat"] as? Double,
                let longitude = jsonDictionary["lon"] as? Double
            else {
                return nil
            }
            
            return Coordinates(latitude: latitude, longitude: longitude)
        } catch {
            print("! JSON parsing error: " + error.localizedDescription)
            return nil
        }
    }
}
