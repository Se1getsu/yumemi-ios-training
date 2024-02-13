//
//  WeatherRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation
import YumemiWeather

/// YumemiWeather から天気を取得するリポジトリ
struct WeatherRepository {
    func fetch() -> Weather {
        let weatherString = YumemiWeather.fetchWeatherCondition()
        return .init(rawValue: weatherString) ?? .unknown
    }
}
