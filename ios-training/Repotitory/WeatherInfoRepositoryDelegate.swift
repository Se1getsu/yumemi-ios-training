//
//  WeatherInfoRepositoryDelegate.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/19.
//

import Foundation

/// `WeatherInfoRepositoryProtocol`からの通知を受け取る
protocol WeatherInfoRepositoryDelegate: AnyObject {
    /// フェッチが完了した時の処理
    ///
    /// 失敗時には原因に応じたエラーが渡される。
    /// - 取得に失敗した場合は YumemiWeatherError
    /// - エンコードやデコードに失敗した場合はそれに対応するエラー
    func didFetch(result: Result<WeatherInfo, Error>)
}
