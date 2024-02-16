//
//  WeatherInfoRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

/// 天気に関する情報を取得するリポジトリ
protocol WeatherInfoRepository {
    /// 天気に関する情報を取得する
    func fetch(at area: String, date: Date) throws -> WeatherInfo
}