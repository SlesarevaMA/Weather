//
//  TodayWeatherView.swift
//  Weather
//
//  Created by Margarita Slesareva on 19.07.2023.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

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
    
    private var city: String {
        get {
            return cityTextField.text ?? ""
        }
        
        set {
            cityTextField.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
//        cityTextField.rx.textInput
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCity() -> String {
        if city.isEmpty {
            cityTextField.text = "Moscow"
            return "Moscow"
        }
        
        return city
    }
    
    func configure(with model: WeatherModel) {
        temperatureLabel.text = "\(model.temperature)"
        feelsLikeTemperatureLabel.text = "\(model.feelsLikeTemperature)"
        extremumTemperatureLabel.text = "min: \(model.minTemperature), max: \(model.maxTemperature)"
        descriptionLabel.text = model.description
        pressureLabel.text = "\(model.pressure)"
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
            $0.centerY.equalToSuperview()
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
//        cityTextField.addTarget(self, action: #selector(setText), for: .valueChanged)
        cityTextField.placeholder = "City"
        cityTextField.borderStyle = .roundedRect
//        cityTextField.delegate = self
    }
    
//    @objc private func setText() {
//        city = cityTextField.text ?? ""
//    }
}

//extension TodayWeatherView: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        city = textField.text ?? ""
//    }
//}
