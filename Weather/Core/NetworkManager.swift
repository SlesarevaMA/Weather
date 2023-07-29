//
//  NetworkManager.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import Foundation
import Combine

enum NetworkError: Error {
    case noData
    case invalidRequest
    case invalidResponse(Int)
    case other(Error)
    case decode(Error)
}

enum WeatherError: Error {
    case selfReleased
}

protocol NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
    func sendRequest(request: Request) -> AnyPublisher<Data, Error>
}

final class NetworkManagerImpl: NetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = session.dataTask(with: request.urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                completion(.success(data))
            } else if let error {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
    
    func sendRequest(request: Request) -> AnyPublisher<Data, Error> {
        return session.dataTaskPublisher(for: request.urlRequest)
            .tryMap { data, response in
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
                    throw NetworkError.invalidResponse(statusCode)
                }
                
                return data
            }
            .eraseToAnyPublisher()
    }
}
