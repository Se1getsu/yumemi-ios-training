//
//  AreaListPresetnerOutput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

@MainActor
protocol AreaListPresetnerOutput: AnyObject {
    /// WeatherViewに遷移する
    func transitToWeatherView()
}
