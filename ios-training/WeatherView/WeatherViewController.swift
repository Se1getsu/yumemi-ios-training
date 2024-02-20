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
    
    private let weatherFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let weatherImagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Reloadを押して\n天気を読み込む"
        return label
    }()
    
    private let minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    private let highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reload", for: .normal)
        return button
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Properties - Dependencies
    
    private var presenter: WeatherPresenterInput!
    
    // MARK: Lifecycle
    
    func inject(presenter: WeatherPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviewUIs()
        setUpLayout()
        registerEvent()
    }
}

// MARK: - WeatherViewPresenterInput

extension WeatherViewController: WeatherPresenterOutput {
    func dismiss() {
        dismiss(animated: true)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        weatherImagePlaceholderLabel.isHidden = true
        closeButton.isEnabled = false
        reloadButton.isEnabled = false
    }
    
    func finishLoading() {
        activityIndicator.stopAnimating()
        closeButton.isEnabled = true
        reloadButton.isEnabled = true
    }
    
    func showWeatherInfo(weatherInfo: WeatherInfo) {
        weatherImageView.image = .weatherImage(for: weatherInfo.weather)
        weatherImageView.tintColor = self.imageTint(for: weatherInfo.weather)
        minimumTemperatureLabel.text = weatherInfo.minimumTemperature.description
        highTemperatureLabel.text = weatherInfo.highTemperature.description
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
        weatherImageView.image = nil
        weatherImagePlaceholderLabel.text = "取得エラー"
        weatherImagePlaceholderLabel.isHidden = false
        minimumTemperatureLabel.text = "--"
        highTemperatureLabel.text = "--"
    }
}

// MARK: - Private

private extension WeatherViewController {
    /// UIをaddSubViewする処理
    func addSubviewUIs() {
        view.addSubview(weatherFrame)
        view.addSubview(weatherImageView)
        view.addSubview(weatherImagePlaceholderLabel)
        view.addSubview(minimumTemperatureLabel)
        view.addSubview(highTemperatureLabel)
        view.addSubview(closeButton)
        view.addSubview(reloadButton)
        view.addSubview(activityIndicator)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() { // swiftlint:disable:this function_body_length
        let safeArea = view.safeAreaLayoutGuide
        
        weatherFrame.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherFrame.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            weatherFrame.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            weatherFrame.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5)
        ])
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: weatherFrame.topAnchor),
            weatherImageView.centerXAnchor.constraint(equalTo: weatherFrame.centerXAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: weatherFrame.widthAnchor),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1.0)
        ])
        
        weatherImagePlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImagePlaceholderLabel.topAnchor.constraint(equalTo: weatherImageView.topAnchor),
            weatherImagePlaceholderLabel.bottomAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            weatherImagePlaceholderLabel.leadingAnchor.constraint(equalTo: weatherImageView.leadingAnchor),
            weatherImagePlaceholderLabel.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor)
        ])
        
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minimumTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            minimumTemperatureLabel.bottomAnchor.constraint(equalTo: weatherFrame.bottomAnchor),
            minimumTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImageView.leadingAnchor),
            minimumTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.5)
        ])
        
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            highTemperatureLabel.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            highTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.5)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: minimumTemperatureLabel.bottomAnchor, constant: 80),
            closeButton.centerXAnchor.constraint(equalTo: minimumTemperatureLabel.centerXAnchor)
        ])
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: highTemperatureLabel.bottomAnchor, constant: 80),
            reloadButton.centerXAnchor.constraint(equalTo: highTemperatureLabel.centerXAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: safeArea.topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    /// 画面のイベント処理を登録する
    func registerEvent() {
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        reloadButton.addTarget(self, action: #selector(didTapReloadButton), for: .touchUpInside)
    }
    
    @objc private func didTapCloseButton() {
        presenter.didTapCloseButton()
    }
    
    @objc private func didTapReloadButton() {
        presenter.didTapReloadButton()
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

//#Preview {
//    WeatherViewController(
//        weatherInfoRepository: WeatherInfoRepository(
//            apiEncoder: YumemiWeatherAPIEncoder(),
//            apiDecoder: YumemiWeatherAPIDecoder()
//        )
//    )
//}
