//
//  SpyWeatherView.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import UIKit
@testable import ios_training

class SpyWeatherView: UIView, WeatherViewProtocol {
    // MARK: Properties
    
    weak var eventHandler: WeatherViewEventHandler?
    
    // MARK: UI
    
    let weatherImageView = UIImageView()
    let weatherImagePlaceholderLabel = UILabel()
    let minimumTemperatureLabel = UILabel()
    let highTemperatureLabel = UILabel()
    let closeButton = UIButton()
    let reloadButton = UIButton()
}
