//
//  WeatherPresenterOutput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import UIKit

@MainActor
protocol WeatherPresenterOutput: AnyObject {
    /// dismissする
    func dismiss()
    
    /// ローディング表示を開始する
    func startLoading()
    
    /// ローディング表示を終了する
    func finishLoading()
    
    /// 天気に関する情報を画面に表示する
    func showWeatherInfo(weatherInfo: WeatherInfo)
    
    /// 天気の取得に失敗した旨のアラートを表示する
    func showFetchErrorAlert()
}
