//
//  WeatherRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 15.07.2023.
//

import Foundation
import Combine

protocol WeatherRequestService {
    func requestWeather(coordinates: Coordinates) -> AnyPublisher<WeatherParameters, Error>
}

final class WeatherRequestServiceImpl: WeatherRequestService {
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestWeather(coordinates: Coordinates) -> AnyPublisher<WeatherParameters, Error> {
        let weatherRequest = WeatherRequest(coordinates: coordinates)
        
        return networkManager.sendRequest(request: weatherRequest)
            .decode(type: WeatherParameters.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
