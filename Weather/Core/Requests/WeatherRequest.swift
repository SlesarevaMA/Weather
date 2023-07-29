//
//  WeatherRequest.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

struct WeatherRequest: Request {
    private let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "lat", value: "\(coordinates.latitude)"),
            URLQueryItem(name: "lon", value: "\(coordinates.longitude)")
        ])
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create weather url")
        }
        
        return URLRequest(url: url)
    }
}
