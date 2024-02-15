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
    /// - returns: 天気。`Weather`で未定義のものを取得した場合は`nil`を返す
    func fetch() -> Weather? {
        let weatherString = YumemiWeather.fetchWeatherCondition()
        return .init(rawValue: weatherString)
    }
}
