//
//  WeatherInfoRepositoryProtocol.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

/// 天気に関する情報を取得するリポジトリ
protocol WeatherInfoRepositoryProtocol {
    // MARK: Properties
    
    var delegate: WeatherInfoRepositoryDelegate? { get set }
    
    // MARK: Functions
    
    /// 天気に関する情報を取得をリクエストする
    ///
    /// 取得の結果は`delegate`で通知される。
    func requestFetch(at area: String, date: Date)
}
