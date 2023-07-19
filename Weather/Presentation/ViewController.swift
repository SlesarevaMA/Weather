//
//  ViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    private let todayWeatherView = TodayWeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        let provider = DataProviderImpl(
            cityRequestService: ServiceAssembly.cityRequestService,
            weatherRequestService: ServiceAssembly.weatherRequestService,
            mapper: MapperImpl()
        )
        
        provider.getData(for: "")
    }
}
