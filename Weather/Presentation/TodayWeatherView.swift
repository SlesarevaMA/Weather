//
//  TodayWeatherView.swift
//  Weather
//
//  Created by Margarita Slesareva on 19.07.2023.
//

import UIKit
import SnapKit
import Combine

private enum Metrics {
    static let horizontalSpacing: CGFloat = 15
    static let verticalSpacing: CGFloat = 8
    static let maxVerticalSpacing: CGFloat = 25
}

final class TodayWeatherView: UIView {
    private let cityTextField = UITextField()
    private let temperatureLabel = UILabel()
    private let feelsLikeTemperatureLabel = UILabel()
    private let extremumTemperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let pressureLabel = UILabel()
    
    @Published var city: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: WeatherModel?) {
        guard let model else {
            clearLabels()
            return
        }

        temperatureLabel.text = "Current temperature: \(model.temperature)"
        feelsLikeTemperatureLabel.text = "Feel like: \(model.feelsLikeTemperature)"
        extremumTemperatureLabel.text = "min: \(model.minTemperature), max: \(model.maxTemperature)"
        descriptionLabel.text = model.description
        pressureLabel.text = "Pressure \(model.pressure) mmHg"
    }
    
    private func clearLabels() {
        [
            temperatureLabel,
            feelsLikeTemperatureLabel,
            extremumTemperatureLabel,
            descriptionLabel,
            pressureLabel
        ].forEach { label in
            label.text = nil
        }
    }
    
    private func configure() {
        addSubview()
        addConstraint()
        configureViews()
    }
    
    private func addSubview() {
        [cityTextField, temperatureLabel, feelsLikeTemperatureLabel, extremumTemperatureLabel,
         descriptionLabel, pressureLabel]
            .forEach { addSubview($0) }
    }
    
    private func addConstraint() {
        cityTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        feelsLikeTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        extremumTemperatureLabel.snp.makeConstraints {
            $0.top
                .equalTo(feelsLikeTemperatureLabel.snp.bottom)
                .offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top
                .equalTo(extremumTemperatureLabel.snp.bottom)
                .offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configureViews() {
        cityTextField.addTarget(self, action: #selector(setText), for: .editingChanged)
        cityTextField.placeholder = "City"
        cityTextField.borderStyle = .roundedRect
    }
    
    @objc private func setText() {
        city = cityTextField.text ?? ""
    }
}
