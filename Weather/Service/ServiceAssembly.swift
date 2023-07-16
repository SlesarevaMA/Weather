//
//  ServiceAssembly.swift
//  Weather
//
//  Created by Margarita Slesareva on 16.07.2023.
//

final class ServiceAssembly {
    static let cityRequestService: CityRequestService = CityRequestServiceImpl(
        networkManager: CoreAssembly.neworkManager,
        cityParser: CoreAssembly.cityParser
    )
    
    static let weatherRequestService: WeatherRequestService = WeatherRequestServiceImpl(
        networkManager: CoreAssembly.neworkManager,
        weatherParser: CoreAssembly.weatherParser
    )
}
