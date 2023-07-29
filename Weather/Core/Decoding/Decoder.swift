//
//  Decoder.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

import Foundation

final class WeatherJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        keyDecodingStrategy = .convertFromSnakeCase
    }
    
    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        do {
            let result = try super.decode(type, from: data)
            return result
        } catch {
            if let string = String(data: data, encoding: .utf8) {
                print(string)
            }
            
            throw error
        }
    }
}
