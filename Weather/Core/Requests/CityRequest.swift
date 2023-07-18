//
//  CityRequest.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

struct CityRequest: Request {
    let city: String?
    
    init(city: String?) {
        self.city = city
    }
    
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        urlComponents.path = "/geo/1.0/direct"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "limit", value: "1")
        ])
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create city url")
        }
        
        return URLRequest(url: url)
    }
}
