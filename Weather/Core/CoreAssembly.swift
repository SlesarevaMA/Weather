//
//  CoreAssembly.swift
//  Weather
//
//  Created by Margarita Slesareva on 16.07.2023.
//

final class CoreAssembly {
    static let neworkManager: NetworkManager = NetworkManagerImpl()
    static let cityParser = CityParser()
    static let weatherParser = WeatherParser()
}
