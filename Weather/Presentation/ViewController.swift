//
//  ViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let todayWeatherView = TodayWeatherView()
    
    private let provider = DataProviderImpl(
        cityRequestService: ServiceAssembly.cityRequestService,
        weatherRequestService: ServiceAssembly.weatherRequestService,
        mapper: MapperImpl()
    )
    
    private var city: String {
        return todayWeatherView.getCity()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configure()
        addConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureWithData()
    }

    private func configure() {
        view.backgroundColor = .white
        view.addSubview(todayWeatherView)
    }
    
    private func addConstraint() {
        todayWeatherView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureWithData() {
        provider.getData(for: city)
    }
}
