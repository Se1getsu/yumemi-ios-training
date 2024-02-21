//
//  AreaListPresetnerOutput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

@MainActor
protocol AreaListPresetnerOutput: AnyObject {
    /// WeatherViewに遷移する
    func transitToWeatherView()
    
    /// ローディング表示を開始する
    func startLoading()
    
    /// ローディング表示を終了する
    func finishLoading()
    
    /// 表示されている内容を更新する
    func reloadData()
    
    /// 天気の取得に失敗した旨のアラートを表示する
    func showFetchErrorAlert()
}
