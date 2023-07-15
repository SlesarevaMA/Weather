//
//  ViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let service: CityRequestService

    init(service: CityRequestService = CityRequestServiceImpl()) {
        self.service = service
        
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
        service.requestCityData(city: "Moscow") { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.requestWeather(for: coordinates)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func requestWeather(for coordinates: Coordinates) {
        print(coordinates)
    }
}
