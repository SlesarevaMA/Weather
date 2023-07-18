//
//  WeatherRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 15.07.2023.
//

import Foundation

protocol WeatherRequestService {
    func requestWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherParameters, Error>) -> Void)
}

final class WeatherRequestServiceImpl: WeatherRequestService {
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
        
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestWeather(coordinates: Coordinates, completion: @escaping (Result<WeatherParameters, Error>) -> Void) {
        let weatherRequest = WeatherRequest(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        networkManager.sendRequest(request: weatherRequest) { result in
            switch result {
            case .success(let data):
                if let weatherParameters = try? self.decoder.decode(WeatherParameters.self, from: data) {
                    completion(.success(weatherParameters))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
