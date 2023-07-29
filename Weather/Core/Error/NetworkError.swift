//
//  NetworkError.swift
//  Weather
//
//  Created by Margarita Slesareva on 29.07.2023.
//

enum NetworkError: Error {
    case noData
    case invalidRequest
    case invalidResponse(Int)
    case other(Error)
    case decode(Error)
}
