//
//  Decoder.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

import Foundation

final class WeatherJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
