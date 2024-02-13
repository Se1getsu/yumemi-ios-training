//
//  Weather.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// 天気の情報を表すエンティティ
enum Weather: String {
    /// 晴れ
    case sunny
    /// 曇り
    case cloudy
    /// 雨
    case rainy
    /// 未定義の天気
    case unknown
    
    /// `UIImageVIew.tintColor` に指定するための色
    var imageTint: UIColor? {
        switch self {
        case .sunny:        .systemRed
        case .cloudy:       .systemGray
        case .rainy:        .tintColor
        case .unknown:      nil
        }
    }
}
