//
//  MainView.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

final class MainView: UIView {
    // MARK: UI
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        return button
    }()
    
    // MARK: メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviewUIs()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainView {
    /// UIをaddSubViewする処理
    func addSubviewUIs() {
        addSubview(weatherImageView)
        addSubview(minimumTemperatureLabel)
        addSubview(highTemperatureLabel)
        addSubview(closeButton)
        addSubview(reloadButton)
    }
    
    /// オートレイアウトの設定処理
    func setUpLayout() {
        let safeArea = safeAreaLayoutGuide
        
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            weatherImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1.0)
        ])
        
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minimumTemperatureLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor),
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
}

#Preview("UIKit") {
    return MainViewController()
}
