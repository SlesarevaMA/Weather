//
//  CityRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

protocol CityRequestService {
    func requestCityData(city: String, competion: @escaping (Result<Coordinates, Error>) -> Void)
}

final class CityRequestServiceImpl: CityRequestService {
    
    private let networkManager: NetworkManager
    private let cityParser: Parser
    
    init(networkManager: NetworkManager = NetworkManagerImpl(), cityParser: Parser = CityParser()) {
        self.networkManager = networkManager
        self.cityParser = cityParser
    }
    
    func requestCityData(city: String, competion: @escaping (Result<Coordinates, Error>) -> Void) {
        let cityRequest = CityRequest(city: city)
        
        networkManager.sendRequest(request: cityRequest) { result in
            switch result {
            case .success(let data):
                if let coordinates = self.cityParser.parseData(data: data) {
                    competion(.success(coordinates))
                }
            case .failure(let error):
                competion(.failure(error))
            }
        }
    }
}
