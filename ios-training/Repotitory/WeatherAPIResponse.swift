//
//  WeatherAPIResponse.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

/// `YumemiWeather.fetchWeather(_:)` のレスポンス
struct WeatherAPIResponse: Decodable {
    let date: Date
    let weatherCondition: String
    let minTemperature: Int
    let maxTemperature: Int
}
