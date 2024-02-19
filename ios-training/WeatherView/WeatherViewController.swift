//
//  WeatherViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// 天気を表示する画面
final class WeatherViewController: UIViewController {
    // MARK: Properties
    
    private let myView: WeatherViewProtocol
    
    // MARK: Dependencies
    
    private let weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: WeatherViewProtocol = WeatherView(), weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.myView = view
        self.weatherInfoRepository = weatherInfoRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        myView.eventHandler = self
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.loadWeather()
        }
    }
}

// MARK: - WeatherViewEventHandler

extension WeatherViewController: WeatherViewEventHandler {
    func didTapCloseButton() {
        dismiss(animated: true)
    }
    
    func didTapReloadButton() {
        loadWeather()
    }
}

// MARK: - Private

private extension WeatherViewController {
    /// 天気を読み込む
    func loadWeather() {
        myView.weatherImageView.image = nil
        myView.weatherImagePlaceholderLabel.isHidden = true
        do {
            let weatherInfo = try weatherInfoRepository.fetch(at: "tokyo", date: Date())
            myView.weatherImageView.image = .weatherImage(for: weatherInfo.weather)
            myView.weatherImageView.tintColor = imageTint(for: weatherInfo.weather)
            myView.minimumTemperatureLabel.text = weatherInfo.minimumTemperature.description
            myView.highTemperatureLabel.text = weatherInfo.highTemperature.description
        } catch {
            let alert = AlertMaker.retryOrCancelAlert(
                title: "天気の取得に失敗しました",
                message: "再試行しますか？",
                didTapRetry: { [unowned self] _ in
                    self.loadWeather()
                },
                didTapCancel: nil
            )
            present(alert, animated: true)
            myView.weatherImageView.image = nil
            myView.weatherImagePlaceholderLabel.text = "取得エラー"
            myView.weatherImagePlaceholderLabel.isHidden = false
            myView.minimumTemperatureLabel.text = "--"
            myView.highTemperatureLabel.text = "--"
        }
    }
    
    /// `weatherImageView.tintColor` に指定するための色を返す
    func imageTint(for weather: Weather) -> UIColor {
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

// MARK: - Preview

#Preview {
    WeatherViewController(
        weatherInfoRepository: WeatherInfoRepository(
            apiEncoder: YumemiWeatherAPIEncoder(),
            apiDecoder: YumemiWeatherAPIDecoder()
        )
    )
}
