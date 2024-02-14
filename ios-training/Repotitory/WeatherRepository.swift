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
    /// 天気を取得する
    func fetch(at area: String) throws -> Weather {
        let weatherString = try YumemiWeather.fetchWeatherCondition(at: area)
        guard let weather = Weather(rawValue: weatherString) else {
            throw RepositoryError.undefinedWeather
        }
        return weather
    }
}
