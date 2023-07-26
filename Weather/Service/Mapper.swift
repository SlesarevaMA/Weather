//
//  Mapper.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

protocol Mapper {
    func mapCoordinates(from apiModel: City) -> Coordinates
    func mapWeatherViewModel(from apiModel: WeatherParameters) -> WeatherModel
}

final class MapperImpl: Mapper {
    func mapCoordinates(from apiModel: City) -> Coordinates {
        return Coordinates(latitude: apiModel.lat, longitude: apiModel.lon)
    }
    
    func mapWeatherViewModel(from apiModel: WeatherParameters) -> WeatherModel {
        return WeatherModel(
            description: apiModel.weather[0].description,
            temperature: apiModel.main.temp,
            feelsLikeTemperature: apiModel.main.feelsLike,
            minTemperature: apiModel.main.tempMin,
            maxTemperature: apiModel.main.tempMax,
            pressure: apiModel.main.pressure
        )
    }
}
