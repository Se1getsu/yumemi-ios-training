//
//  WeatherView.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

final class WeatherView: UIView {
    // MARK: Properties
    
    weak var eventHandler: WeatherViewEventHandler?
    
    // MARK: Properties - UI
    
    let weatherFrame: UIView = {
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
        label.isHidden = true
        return label
    }()
    
    let minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    let highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.text = "--"
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()
    
    let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()
    
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

// MARK: Private

private extension WeatherView {
    /// UIをaddSubViewする処理
    func addSubviewUIs() {
        addSubview(weatherFrame)
        addSubview(weatherImageView)
        addSubview(weatherImagePlaceholderLabel)
        addSubview(minimumTemperatureLabel)
        addSubview(highTemperatureLabel)
        addSubview(closeButton)
        addSubview(reloadButton)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() {
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
    }
    
    /// 画面のイベント処理を登録する
    func registerEvent() {
        reloadButton.addTarget(self, action: #selector(didTapReloadButton), for: .touchUpInside)
    }
    
    @objc private func didTapReloadButton() {
        eventHandler?.didTapReloadButton()
    }
}
