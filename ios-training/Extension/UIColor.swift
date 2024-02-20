//
//  UIColor.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/20.
//

import UIKit.UIColor

extension UIColor {
    /// 天気の色
    static func weatherTint(for weather: Weather) -> UIColor {
        switch weather {
        case .sunny:
            UIColor.systemRed
        case .cloudy:
            UIColor.systemGray
        case .rainy:
            UIColor.tintColor
        }
    }
}
