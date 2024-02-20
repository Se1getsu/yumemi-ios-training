//
//  WeatherView.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

final class WeatherView: UIView, WeatherViewProtocol {
    // MARK: Properties
    
    weak var eventHandler: WeatherViewEventHandler?
    
    // MARK: Properties - UI
    
    private let weatherFrame: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let weatherImagePlaceholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Reloadを押して\n天気を読み込む"
        return label
    }()
    
    let lowestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    let highestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reload", for: .normal)
        return button
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviewUIs()
        setUpLayout()
        registerEvent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension WeatherView {
    /// UIをaddSubViewする処理
    func addSubviewUIs() {
        addSubview(weatherFrame)
        addSubview(weatherImageView)
        addSubview(weatherImagePlaceholderLabel)
        addSubview(lowestTemperatureLabel)
        addSubview(highestTemperatureLabel)
        addSubview(closeButton)
        addSubview(reloadButton)
        addSubview(activityIndicator)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() { // swiftlint:disable:this function_body_length
        let safeArea = safeAreaLayoutGuide
        
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
        
        lowestTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowestTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            lowestTemperatureLabel.bottomAnchor.constraint(equalTo: weatherFrame.bottomAnchor),
            lowestTemperatureLabel.leadingAnchor.constraint(equalTo: weatherImageView.leadingAnchor),
            lowestTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.5)
        ])
        
        highestTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highestTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
            highestTemperatureLabel.trailingAnchor.constraint(equalTo: weatherImageView.trailingAnchor),
            highestTemperatureLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 0.5)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: lowestTemperatureLabel.bottomAnchor, constant: 80),
            closeButton.centerXAnchor.constraint(equalTo: lowestTemperatureLabel.centerXAnchor)
        ])
        
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: highestTemperatureLabel.bottomAnchor, constant: 80),
            reloadButton.centerXAnchor.constraint(equalTo: highestTemperatureLabel.centerXAnchor)
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
        eventHandler?.didTapCloseButton()
    }
    
    @objc private func didTapReloadButton() {
        eventHandler?.didTapReloadButton()
    }
}

// MARK: - Preview

#Preview {
    let view = WeatherView()
    view.weatherImageView.backgroundColor = .green.withAlphaComponent(0.2)
    return PreviewViewController(view: view)
}
