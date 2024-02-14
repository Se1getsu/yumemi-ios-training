//
//  WeatherViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// 天気を表示する画面
class WeatherViewController: UIViewController {
    // MARK: 依存
    private let myView = WeatherView()
    private let weatherRepository: WeatherRepository
    private let weatherImageRepository: WeatherImageRepository
    
    // MARK: メソッド
    init(weatherRepository: WeatherRepository, weatherImageRepository: WeatherImageRepository) {
        self.weatherRepository = weatherRepository
        self.weatherImageRepository = weatherImageRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        myView.reloadButton.addTarget(self, action: #selector(didTapReloadButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadWeather()
    }
    
    @objc func didTapReloadButton() {
        loadWeather()
    }
}

private extension WeatherViewController {
    /// 天気を読み込む
    func loadWeather() {
        myView.weatherImagePlaceholderLabel.isHidden = true
        if let weather = weatherRepository.fetch() {
            myView.weatherImageView.image = weatherImageRepository.image(for: weather)
            myView.weatherImageView.tintColor = imageTint(for: weather)
        } else {
            myView.weatherImagePlaceholderLabel.text = "未定義の天気"
            myView.weatherImagePlaceholderLabel.isHidden = false
        }
    }
    
    /// `weatherImageView.tintColor` に指定するための色を返す。
    func imageTint(for weather: Weather) -> UIColor? {
        switch weather {
        case .sunny:
            UIColor.systemRed
        case .cloudy:
            UIColor.systemGray
        case .rainy:
            UIColor.tintColor
        }
    }
}

#Preview("UIKit") {
    return WeatherViewController(
        weatherRepository: WeatherRepository(),
        weatherImageRepository: WeatherImageRepository()
    )
}
