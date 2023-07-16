//
//  WeatherRequest.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

struct WeatherRequest: Request {
    
    let latitude: Double?
    let longitude: Double?
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var urlRequest: URLRequest {
        var urlComponents = baseUrlComponents
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "lat", value: "\(latitude ?? 0)"),
            URLQueryItem(name: "lon", value: "\(longitude ?? 0)")
        ])
        
        guard let url = urlComponents.url else {
            fatalError("Unable to create weather url")
        }
        
        return URLRequest(url: url)
    }
}
