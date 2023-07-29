//
//  CityRequestService.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation
import Combine

protocol CityRequestService {
    func requestCityData(city: String, completion: @escaping (Result<[City], Error>) -> Void)
    func requestCityData(city: String) -> AnyPublisher<[City], Error>
}

final class CityRequestServiceImpl: CityRequestService {
    private let networkManager: NetworkManager
    private let decoder: JSONDecoder
    
    init(networkManager: NetworkManager, decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.decoder = decoder
    }
    
    func requestCityData(city: String, completion: @escaping (Result<[City], Error>) -> Void) {
        let cityRequest = CityRequest(city: city)
        
        networkManager.sendRequest(request: cityRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let city = try self.decoder.decode([City].self, from: data)
                    completion(.success(city))
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestCityData(city: String) -> AnyPublisher<[City], Error> {
        let cityRequest = CityRequest(city: city)
        
        return networkManager.sendRequest(request: cityRequest)
            .decode(type: [City].self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
