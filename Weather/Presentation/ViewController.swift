//
//  ViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    private let cityRequestService: CityRequestService
    private let weatherRequestService: WeatherRequestService
    
    
    
    init(cityRequestService: CityRequestService, weatherRequestService: WeatherRequestService) {
        self.cityRequestService = cityRequestService
        self.weatherRequestService = weatherRequestService
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        requestCityData()
    }
    
    private func requestCityData() {
        cityRequestService.requestCityData(city: "Moscow") { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.requestWeather(for: coordinates)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestWeather(for coordinates: Coordinates) {
        weatherRequestService.requestWeather(coordinates: coordinates) { result in
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
}
