//
//  RepositoryError.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

enum RepositoryError: Error {
    /// `Weather`に未定義の天気を取得した場合のエラー
    case undefinedWeather
}
