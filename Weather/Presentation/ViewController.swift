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
    
    private let viewModel: ViewModel = ViewModelImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
        configure()
        addConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let city = todayWeatherView.getCity()
        
        viewModel.addCity(city: city)
    }
    
    func setupBindings() {
        viewModel.weatherModel.bind({ model in
            DispatchQueue.main.async {
                self.todayWeatherView.configure(with: model)
            }
        })
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
