//
//  AreaCell.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import UIKit

final class AreaCell: UITableViewCell {
    // MARK: Properties - UI
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let areaLabel: UILabel = UILabel()
    
    private let highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .right
        label.text = "--"
        return label
    }()
    
    private let minimumTemperatureLabel: UILabel = {
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
    
    var area: Area? {
        didSet {
            areaLabel.text = area?.description
        }
    }
    
    var weatherInfo: WeatherInfo? {
        didSet {
            if let weatherInfo {
                weatherImageView.image = .weatherImage(for: weatherInfo.weather)
                weatherImageView.tintColor = .weatherTint(for: weatherInfo.weather)
                highTemperatureLabel.text = weatherInfo.highTemperature.description
                minimumTemperatureLabel.text = weatherInfo.minimumTemperature.description
            } else {
                weatherImageView.image = nil
                highTemperatureLabel.text = "--"
                minimumTemperatureLabel.text = "--"
            }
        }
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
