//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

import Combine
import Foundation

protocol WeatherViewModel {
    var citySubject: CurrentValueSubject<String, Never> { get }
    var currentWeatherSubject: CurrentValueSubject<WeatherModel?, Never> { get }
}

final class WeatherViewModelImpl: WeatherViewModel {
    let currentWeatherSubject = CurrentValueSubject<WeatherModel?, Never>(nil)
    let citySubject = CurrentValueSubject<String, Never>("London")
        
    private let cityRequestService: CityRequestService
    private let weatherRequestService: WeatherRequestService
    private let mapper: Mapper
    
    private var cancellable: AnyCancellable?
        
    init(
        cityRequestService: CityRequestService = ServiceAssembly.cityRequestService,
        weatherRequestService: WeatherRequestService = ServiceAssembly.weatherRequestService,
        mapper: Mapper = MapperImpl()
    ) {
        self.cityRequestService = cityRequestService
        self.weatherRequestService = weatherRequestService
        self.mapper = mapper
        
        bind()
    }
    
    private func bind() {
        cancellable = citySubject
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .flatMap { [weak self] city in
                guard let self else {
                    return Just<WeatherModel?>(nil)
                        .eraseToAnyPublisher()
                }
                
                return self.getDataPublisher(for: city)
                    .map { Optional($0) }
                    .replaceError(with: nil)
                    .eraseToAnyPublisher()
            }
            .receive(on: RunLoop.main)
            .assign(to: \.currentWeatherSubject.value, on: self)
    }
    
    private func getDataPublisher(for city: String) -> AnyPublisher<WeatherModel, Error> {
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
