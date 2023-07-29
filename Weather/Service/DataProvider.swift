//
//  DataProvider.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

import Foundation
import Combine

protocol DataProvider {
    func getData(for city: String) -> AnyPublisher<WeatherModel, Error>
}

final class DataProviderImpl: DataProvider {
    private let cityRequestService: CityRequestService
    private let weatherRequestService: WeatherRequestService
    private let mapper: Mapper
        
    init(cityRequestService: CityRequestService, weatherRequestService: WeatherRequestService, mapper: Mapper) {
        self.cityRequestService = cityRequestService
        self.weatherRequestService = weatherRequestService
        self.mapper = mapper
    }
    
    func getData(for city: String) -> AnyPublisher<WeatherModel, Error> {
        cityRequestService.requestCityData(city: city)
            .compactMap(\.first)
            .map(mapper.mapCoordinates)
            .flatMap { [weak self] coordinates in
                guard let self else {
                    return Fail<WeatherModel, Error>(error: WeatherError.selfReleased)
                        .eraseToAnyPublisher()
                }
                
                return self.weatherRequestService.requestWeather(coordinates: coordinates)
                    .map(self.mapper.mapWeatherViewModel)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
