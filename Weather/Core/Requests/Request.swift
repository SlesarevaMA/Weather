//
//  Request.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

extension Request {
    var baseUrlComponents: URLComponents {
        let appId = ProcessInfo.processInfo.environment["APPID"]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.queryItems = [
            URLQueryItem(name: "appid", value: appId)
        ]
        
        return urlComponents
    }
}
