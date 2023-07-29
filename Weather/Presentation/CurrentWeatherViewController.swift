//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit
import SnapKit
import Combine

private enum Metrics {
    static let backgroundColor: UIColor = .systemCyan
}

final class CurrentWeatherViewController: UIViewController {
    private let todayWeatherView = TodayWeatherView()
    private var viewModel: WeatherViewModel = WeatherViewModelImpl()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addConstraint()
        bindData()
    }
    
    private func configure() {
        view.backgroundColor = Metrics.backgroundColor
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
    
    private func bindData() {
        todayWeatherView.$city
            .assign(to: \.citySubject.value, on: viewModel)
            .store(in: &subscriptions)
        
        viewModel.currentWeatherSubject
            .sink { [weak self] currentWeather in
                self?.todayWeatherView.configure(with: currentWeather)
            }
            .store(in: &subscriptions)
    }
}
