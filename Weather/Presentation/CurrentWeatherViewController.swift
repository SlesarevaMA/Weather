//
//  CurrentWeatherViewController.swift
//  Weather
//
//  Created by Margarita Slesareva on 11.07.2023.
//

import UIKit
import SnapKit
import Combine

final class CurrentWeatherViewController: UIViewController {
    private let todayWeatherView = TodayWeatherView()
    private var viewModel: WeatherViewModel = WeatherViewModelImpl()
    private var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addConstraint()
        getData()
    }
    
    private func getData() {
        subscription = todayWeatherView.$city
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .flatMap { [weak self] cityName in
                guard let self else {
                    fatalError()
                }

                return self.viewModel.weatherPublisher(for: cityName)
            }
            .receive(on: DispatchQueue.main)
//            .catch({ _ -> AnyPublisher<WeatherModel, Error> in
////                return Result.Publisher(nil).eraseToAnyPublisher()
//            })
            .sink(receiveCompletion: { failure in
                print(failure)
            }) { [weak self] weatherModel in
//                print(weatherModel)
                self?.todayWeatherView.configure(with: weatherModel)
            }
        
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
}
