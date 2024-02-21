//
//  AreaCell.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import UIKit

final class AreaCell: UITableViewCell {
    // MARK: Properties - UI
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let areaLabel: UILabel = UILabel()
    
    let highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.text = "--"
        return label
    }()
    
    let minimumTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.text = "--"
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviewUIs()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    func loadWeatherInfo(_ weatherInfo: WeatherInfo) {
        weatherImageView.image = .weatherImage(for: weatherInfo.weather)
        weatherImageView.tintColor = .weatherTint(for: weatherInfo.weather)
        highTemperatureLabel.text = weatherInfo.highTemperature.description
        minimumTemperatureLabel.text = weatherInfo.minimumTemperature.description
    }
}

// MARK: - Private

private extension AreaCell {
    func addSubviewUIs() {
        contentView.addSubview(weatherImageView)
        contentView.addSubview(areaLabel)
        contentView.addSubview(highTemperatureLabel)
        contentView.addSubview(minimumTemperatureLabel)
    }
    
    func setUpLayout() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 32),
            weatherImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            areaLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 8),
            areaLabel.trailingAnchor.constraint(equalTo: minimumTemperatureLabel.leadingAnchor),
            areaLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            areaLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        highTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            highTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            highTemperatureLabel.widthAnchor.constraint(equalToConstant: 38),
            highTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            highTemperatureLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minimumTemperatureLabel.trailingAnchor.constraint(equalTo: highTemperatureLabel.leadingAnchor),
            minimumTemperatureLabel.widthAnchor.constraint(equalToConstant: 38),
            minimumTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minimumTemperatureLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
