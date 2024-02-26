//
//  WeatherViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// 天気を表示する画面
final class WeatherViewController: UIViewController {
    // MARK: Properties - UI
    
    private let myView = WeatherView()
    
    // MARK: Properties - Dependencies
    
    private var presenter: WeatherPresenterInput!
    
    // MARK: Lifecycle
    
    func inject(presenter: WeatherPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter.title
        view = myView
        myView.eventHandler = self
        
        NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: nil
        ) { [weak self] _ in
            self?.presenter.willEnterForeground()
        }
    }
}

// MARK: - WeatherViewEventHandler

extension WeatherViewController: WeatherViewEventHandler {
    func didTapCloseButton() {
        presenter.didTapCloseButton()
    }
    
    func didTapReloadButton() {
        presenter.didTapReloadButton()
    }
}

// MARK: - WeatherViewPresenterInput

extension WeatherViewController: WeatherPresenterOutput {
    func dismiss() {
        dismiss(animated: true)
    }
    
    func startLoading() {
        myView.activityIndicator.startAnimating()
        myView.weatherImagePlaceholderLabel.isHidden = true
        myView.closeButton.isEnabled = false
        myView.reloadButton.isEnabled = false
    }
    
    func finishLoading() {
        myView.activityIndicator.stopAnimating()
        myView.closeButton.isEnabled = true
        myView.reloadButton.isEnabled = true
    }
    
    func showWeatherInfo(weatherInfo: WeatherInfo) {
        myView.weatherImagePlaceholderLabel.isHidden = true
        myView.weatherImageView.image = .weatherImage(for: weatherInfo.weather)
        myView.weatherImageView.tintColor = .weatherTint(for: weatherInfo.weather)
        myView.minimumTemperatureLabel.text = weatherInfo.minimumTemperature.description
        myView.highTemperatureLabel.text = weatherInfo.highTemperature.description
    }
    
    func showFetchErrorAlert() {
        let alert = AlertMaker.retryOrCancelAlert(
            title: "天気の取得に失敗しました",
            message: "再試行しますか？",
            didTapRetry: { [unowned self] _ in
                presenter.didTapRetry()
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

// MARK: - Preview

#Preview {
    let vc = WeatherViewController()
    let presenter = WeatherPresenter(
        view: vc,
        weatherInfoRepository: WeatherInfoRepository(
            apiEncoder: YumemiWeatherAPIEncoder(),
            apiDecoder: YumemiWeatherAPIDecoder()
        ),
        area: .tokyo,
        weatherInfo: WeatherInfo(
            weather: .sunny,
            highTemperature: 25,
            minimumTemperature: 15
        )
    )
    vc.inject(presenter: presenter)
    return UINavigationController(rootViewController: vc)
}
