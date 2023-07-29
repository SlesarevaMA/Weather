//
//  CityRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation
import Combine

protocol CityRequestService {
    func requestCityData(city: String) -> AnyPublisher<[City], Error>
}

final class CityRequestServiceImpl: CityRequestService {
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestCityData(city: String) -> AnyPublisher<[City], Error> {
        let cityRequest = CityRequest(city: city)
        
        return networkManager.sendRequest(request: cityRequest)
            .decode(type: [City].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
