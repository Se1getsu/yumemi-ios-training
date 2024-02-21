//
//  AreaListPresenterInput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

@MainActor
protocol AreaListPresenterInput {
    /// 画面に表示する地域のリスト
    var areas: [Area] { get }
    
    /// セルがタップされた時の処理
    func didSelectRowAt(_ index: Int)
    
    /// 特定の地域の天気に関する情報を取得する
    func weatherInfoAt(_ area: Area) -> WeatherInfo?
    
    /// viewDidAppearで行う処理
    func viewDidAppear()
    
    /// アラートのRetryボタンが押された時の処理
    func didTapRetry()
}
