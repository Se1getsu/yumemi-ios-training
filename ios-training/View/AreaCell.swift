//
//  AreaCell.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import UIKit

final class AreaCell: UITableViewCell {
    // MARK: Properties
    
    private var area: Area? {
        didSet {
            areaLabel.text = area?.description
        }
    }
    
    private var weatherInfo: WeatherInfo? {
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
    
    func setInfo(area: Area?, weatherInfo: (Area) -> WeatherInfo?) {
        self.area = area
        self.weatherInfo = area.flatMap { weatherInfo($0) }
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
        weatherImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(8)
            make.centerY.equalTo(contentView)
            make.size.equalTo(32)
        }
        areaLabel.snp.makeConstraints { make in
            make.leading.equalTo(weatherImageView.snp.trailing).offset(8)
            make.trailing.equalTo(minimumTemperatureLabel.snp.leading)
            make.centerY.equalTo(contentView)
            make.height.equalTo(44)
        }
        highTemperatureLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(8)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 38, height: 44))
        }
        minimumTemperatureLabel.snp.makeConstraints { make in
            make.trailing.equalTo(highTemperatureLabel.snp.leading)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 38, height: 44))
        }
    }
}
