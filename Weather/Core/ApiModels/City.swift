//
//  City.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

import Foundation

struct City: Codable {
    let name: String
    let localNames: [String: String]
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}

struct CityResponse: Codable {
    let city: [City]
}

