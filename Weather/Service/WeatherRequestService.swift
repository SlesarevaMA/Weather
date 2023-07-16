//
//  WeatherRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 15.07.2023.
//

import Foundation

protocol WeatherRequestService {
    func requestWeather(coordinates: Coordinates, completion: @escaping (Result<Weather, Error>) -> Void)
}

final class WeatherRequestServiceImpl: WeatherRequestService {
    
    private let networkManager: NetworkManager
    private let weatherParser: WeatherParser
    
    init(networkManager: NetworkManager, weatherParser: WeatherParser) {
        self.networkManager = networkManager
        self.weatherParser = weatherParser
    }
    
    func requestWeather(coordinates: Coordinates, completion: @escaping (Result<Weather, Error>) -> Void) {
        let weatherRequest = WeatherRequest(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        networkManager.sendRequest(request: weatherRequest) { result in
            switch result {
            case .success(let data):
                if let weather = self.weatherParser.parseData(data: data) {
                    completion(.success(weather))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
