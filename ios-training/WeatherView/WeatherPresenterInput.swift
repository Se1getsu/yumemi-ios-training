//
//  WeatherPresenterInput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

@MainActor
protocol WeatherPresenterInput {
    /// ナビゲーションバーのタイトル
    var title: String { get }
    
    /// 画面がフォアグラウンドになる時の処理
    func willEnterForeground()
    
    /// Close ボタンが押された時の処理
    func didTapCloseButton()
    
    /// Reload ボタンが押された時の処理
    func didTapReloadButton()
    
    /// アラートのRetryボタンが押された時の処理
    func didTapRetry()
}
