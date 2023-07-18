//
//  ServiceAssembly.swift
//  Weather
//
//  Created by Margarita Slesareva on 16.07.2023.
//

final class ServiceAssembly {
    static let cityRequestService: CityRequestService = CityRequestServiceImpl(
        networkManager: CoreAssembly.neworkManager,
        decoder: CoreAssembly.decoder
    )
    
    static let weatherRequestService: WeatherRequestService = WeatherRequestServiceImpl(
        networkManager: CoreAssembly.neworkManager,
        decoder: CoreAssembly.decoder
    )
}
