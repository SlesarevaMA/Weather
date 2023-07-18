//
//  CoreAssembly.swift
//  Weather
//
//  Created by Margarita Slesareva on 16.07.2023.
//

import Foundation

final class CoreAssembly {
    static let neworkManager: NetworkManager = NetworkManagerImpl()
    static let decoder: JSONDecoder = WeatherJSONDecoder()
//    static let cityParser = CityParser()
//    static let weatherParser = WeatherParser()
}
