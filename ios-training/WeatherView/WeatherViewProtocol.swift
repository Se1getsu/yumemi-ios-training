//
//  WeatherViewProtocol.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import UIKit

protocol WeatherViewProtocol: UIView {
    // MARK: Properties
    
    var eventHandler: WeatherViewEventHandler? { get set }
    
    // MARK: Properties - UI
    
    var weatherImageView: UIImageView { get }
    var weatherImagePlaceholderLabel: UILabel { get }
    var lowestTemperatureLabel: UILabel { get }
    var highestTemperatureLabel: UILabel { get }
    var closeButton: UIButton { get }
    var reloadButton: UIButton { get }
    var activityIndicator: UIActivityIndicatorView { get }
}
