//
//  WeatherView.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// WeatherViewControllerのUIの配置を行う
final class WeatherView: UIView {
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
        addSubview(minimumTemperatureLabel)
        addSubview(highTemperatureLabel)
        addSubview(closeButton)
        addSubview(reloadButton)
        addSubview(activityIndicator)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() {
        let safeArea = safeAreaLayoutGuide
        
        weatherFrame.snp.makeConstraints { make in
            make.center.equalTo(safeArea)
            make.width.equalTo(safeArea).multipliedBy(0.5)
        }
        weatherImageView.snp.makeConstraints { make in
            make.top.left.right.equalTo(weatherFrame)
            make.height.equalTo(weatherImageView.snp.width)
        }
        weatherImagePlaceholderLabel.snp.makeConstraints { make in
            make.edges.equalTo(weatherImageView)
        }
        minimumTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.bottom.equalTo(weatherFrame)
            make.leading.equalTo(weatherImageView)
            make.width.equalTo(weatherImageView).multipliedBy(0.5)
        }
        highTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.trailing.equalTo(weatherImageView)
            make.width.equalTo(weatherImageView).multipliedBy(0.5)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(minimumTemperatureLabel.snp.bottom).offset(80)
            make.centerX.equalTo(minimumTemperatureLabel)
        }
        reloadButton.snp.makeConstraints { make in
            make.top.equalTo(highTemperatureLabel.snp.bottom).offset(80)
            make.centerX.equalTo(highTemperatureLabel)
        }
        activityIndicator.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
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
