//
//  DataProvider.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

import Foundation

protocol DataProvider {
}

final class DataProviderImpl: DataProvider {
    private let cityRequestService: CityRequestService
    private let weatherRequestService: WeatherRequestService
    private let mapper: Mapper
    
    private var weatherViewModels = [String: WeatherViewModel]()
    
    init(cityRequestService: CityRequestService, weatherRequestService: WeatherRequestService, mapper: Mapper) {
        self.cityRequestService = cityRequestService
        self.weatherRequestService = weatherRequestService
        self.mapper = mapper
    }
    
    func getData(for city: String) {
        requestCityData(city: city)
    }

    private func requestCityData(city: String) {
        cityRequestService.requestCityData(city: city) { result in
            switch result {
            case .success(let city):
                let coordinates = self.mapper.mapCoordinates(from: city[0])
                self.requestWeather(city: city[0].name, for: coordinates)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestWeather(city: String, for coordinates: Coordinates) {
        weatherRequestService.requestWeather(coordinates: coordinates) { result in
            switch result {
            case .success(let weatherParametrs):
                let weatherViewModel = self.mapper.mapWeatherViewModel(from: weatherParametrs)
                self.weatherViewModels[city] = weatherViewModel
            case .failure(let error):
                print(error)
            }
        }
    }
}
