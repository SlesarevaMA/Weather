//
//  ViewModel.swift
//  Weather
//
//  Created by Margarita Slesareva on 26.07.2023.
//

protocol ViewModel {
    var weatherModel: Bindable<WeatherModel> { get }
    func addCity(city: String)
}

final class ViewModelImpl: ViewModel {
    let weatherModel = Bindable<WeatherModel>()
    
    private let provider = DataProviderImpl(
        cityRequestService: ServiceAssembly.cityRequestService,
        weatherRequestService: ServiceAssembly.weatherRequestService,
        mapper: MapperImpl()
    )
    
    func addCity(city: String) {
        provider.getData(for: city) { model in
            self.weatherModel.value = model
        }
    }
}
