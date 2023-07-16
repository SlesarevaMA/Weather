//
//  Parser.swift
//  Weather
//
//  Created by Margarita Slesareva on 12.07.2023.
//

import Foundation

protocol Parser {
    associatedtype Object
    
    func parseData(data: Data) -> Object?
}
