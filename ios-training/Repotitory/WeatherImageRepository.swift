//
//  WeatherImageRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit.UIImage

/// 天気の画像を取得するリポジトリ
struct WeatherImageRepository {
    // MARK: Internal
    
    func image(for weather: Weather) -> UIImage {
        switch weather {
        case .sunny:
            UIImage(resource: .sunny)
        case .cloudy:
            UIImage(resource: .cloudy)
        case .rainy:
            UIImage(resource: .rainy)
        }
    }
}
