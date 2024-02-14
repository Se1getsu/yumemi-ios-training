//
//  WeatherAPIQuery.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

/// `YumemiWeather.fetchWeather(_:)` のクエリ
struct WeatherAPIQuery: Encodable {
    let area: String
    let date: Date
}
