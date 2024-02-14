//
//  WeatherInfo.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

/// 天気に関する情報を表すエンティティ
struct WeatherInfo {
    /// 天気
    let weather: Weather
    /// 最高気温
    let highTemperature: Int
    /// 最低気温
    let minimumTemperature: Int
    
    init?(from response: WeatherAPIResponse) {
        guard let weather = Weather(rawValue: response.weatherCondition) else { return nil }
        self.weather = weather
        self.highTemperature = response.maxTemperature
        self.minimumTemperature = response.minTemperature
    }
}
