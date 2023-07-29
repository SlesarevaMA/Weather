//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

import Combine

protocol WeatherViewModel {
//    var publishRelay: PublishRelay<WeatherModel> { get }
//    var serchText: BehaviorRelay<String> { get set }
    func weatherPublisher(for city: String) -> AnyPublisher<WeatherModel?, Never>
}

final class WeatherViewModelImpl: WeatherViewModel {

    @Published var city: String = "London"
    @Published var currentWeather: WeatherModel?
    
    private let provider: DataProvider = DataProviderImpl(
        cityRequestService: ServiceAssembly.cityRequestService,
        weatherRequestService: ServiceAssembly.weatherRequestService,
        mapper: MapperImpl()
    )
    
    func weatherPublisher(for city: String) -> AnyPublisher<WeatherModel?, Never> {
        return provider.getData(for: city)
            .map { Optional($0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
