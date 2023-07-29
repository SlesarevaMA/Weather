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
    
    enum Font {
        static let title: UIFont = .systemFont(ofSize: 22, weight: .semibold)
        static let city: UIFont = .systemFont(ofSize: 30)
        static let temperature: UIFont = .systemFont(ofSize: 25, weight: .semibold)
        static let feelsLikeTemperature: UIFont = .systemFont(ofSize: 22)
        static let description: UIFont = .systemFont(ofSize: 20, weight: .semibold)
        static let additional: UIFont = .systemFont(ofSize: 20)
    }
    
    enum Color {
        static let text: UIColor = .white
        static let background: UIColor = .systemCyan
    }
}

final class TodayWeatherView: UIView {
    private let titleLabel = UILabel()
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
        [titleLabel, cityTextField, temperatureLabel, feelsLikeTemperatureLabel, extremumTemperatureLabel,
         descriptionLabel, pressureLabel]
            .forEach { addSubview($0) }
    }
    
    private func addConstraint() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        cityTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metrics.maxVerticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityTextField.snp.bottom).offset(Metrics.maxVerticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        feelsLikeTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        extremumTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(feelsLikeTemperatureLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(extremumTemperatureLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
        
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(Metrics.verticalSpacing)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func configureViews() {
        titleLabel.text = "What's the weather in"
        titleLabel.textColor = Metrics.Color.text
        titleLabel.font = Metrics.Font.title
        
        cityTextField.addTarget(self, action: #selector(setText), for: .editingChanged)
        cityTextField.attributedPlaceholder = NSAttributedString(
            string: "City",
            attributes: [.foregroundColor: UIColor.systemGray5]
        )
        cityTextField.textColor = Metrics.Color.text
        cityTextField.borderStyle = .roundedRect
        cityTextField.backgroundColor = Metrics.Color.background
        cityTextField.font = Metrics.Font.city
        
        temperatureLabel.textColor = Metrics.Color.text
        temperatureLabel.font = Metrics.Font.temperature
        
        feelsLikeTemperatureLabel.textColor = Metrics.Color.text
        feelsLikeTemperatureLabel.font = Metrics.Font.feelsLikeTemperature

        extremumTemperatureLabel.textColor = Metrics.Color.text
        extremumTemperatureLabel.font = Metrics.Font.additional
        
        descriptionLabel.textColor = Metrics.Color.text
        descriptionLabel.font = Metrics.Font.description
        
        pressureLabel.textColor = Metrics.Color.text
        pressureLabel.font = Metrics.Font.additional
    }
    
    @objc private func setText() {
        city = cityTextField.text ?? ""
    }
}
