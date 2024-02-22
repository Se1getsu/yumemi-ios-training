//
//  WeatherViewEventHandler.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/14.
//

import Foundation

/// `WeatherView`のイベント処理を行う
protocol WeatherViewEventHandler: AnyObject {
    /// Close ボタンが押された時の処理
    func didTapCloseButton()
    
    /// Reload ボタンが押された時の処理
    func didTapReloadButton()
}
