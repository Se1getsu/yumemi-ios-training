//
//  UIImage.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/15.
//

import UIKit.UIImage

extension UIImage {
    /// 天気の画像を取得する
    static func weatherImage(for weather: Weather) -> UIImage {
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
