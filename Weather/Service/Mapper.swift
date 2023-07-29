//
//  Mapper.swift
//  Weather
//
//  Created by Margarita Slesareva on 17.07.2023.
//

private enum Constants {
    static let kelvin: Double = 273
    static let bar: Double = 1.33
}

protocol Mapper {
    func mapCoordinates(from apiModel: City) -> Coordinates
    func mapWeatherViewModel(from apiModel: WeatherParameters) -> WeatherModel
}

final class MapperImpl: Mapper {
    func mapCoordinates(from apiModel: City) -> Coordinates {
        return Coordinates(latitude: apiModel.lat, longitude: apiModel.lon)
    }
    
    func mapWeatherViewModel(from apiModel: WeatherParameters) -> WeatherModel {
        
        let temperature = apiModel.main.temp - Constants.kelvin
        let feelsLikeTemperature = apiModel.main.feelsLike - Constants.kelvin
        let minTemperature = apiModel.main.tempMin - Constants.kelvin
        let maxTemperature = apiModel.main.tempMax - Constants.kelvin
        let pressure = Int(Double(apiModel.main.pressure) / Constants.bar)
        
        return WeatherModel(
            description: apiModel.weather[0].description,
            temperature: String(format: "%.1f", temperature),
            feelsLikeTemperature:  String(format: "%.1f", feelsLikeTemperature),
            minTemperature:  String(format: "%.1f", minTemperature),
            maxTemperature:  String(format: "%.1f", maxTemperature),
            pressure: pressure
        )
    }
}
