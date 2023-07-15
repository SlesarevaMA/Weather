//
//  NetworkManager.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import Foundation

protocol NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkManagerImpl: NetworkManager {
    func sendRequest(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, response, error in
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
}
