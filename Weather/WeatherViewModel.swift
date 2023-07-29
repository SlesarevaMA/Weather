//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

import Combine

protocol WeatherViewModel {
    func weatherPublisher(for city: String) -> AnyPublisher<WeatherModel?, Never>
}

final class WeatherViewModelImpl: WeatherViewModel {
    @Published var city: String = "London"
    @Published var currentWeather: WeatherModel?
        
    private let cityRequestService: CityRequestService
    private let weatherRequestService: WeatherRequestService
    private let mapper: Mapper
        
    init(
        cityRequestService: CityRequestService = ServiceAssembly.cityRequestService,
        weatherRequestService: WeatherRequestService = ServiceAssembly.weatherRequestService,
        mapper: Mapper = MapperImpl()
    ) {
        self.cityRequestService = cityRequestService
        self.weatherRequestService = weatherRequestService
        self.mapper = mapper
    }
    
    func weatherPublisher(for city: String) -> AnyPublisher<WeatherModel?, Never> {
        return getData(for: city)
            .map { Optional($0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    private func getData(for city: String) -> AnyPublisher<WeatherModel, Error> {
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
