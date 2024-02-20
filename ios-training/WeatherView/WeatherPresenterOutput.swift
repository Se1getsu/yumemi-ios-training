//
//  WeatherPresenterOutput.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import UIKit

protocol WeatherPresenterOutput: AnyObject {
    func dismiss()
    func 読み込み前()
    func 読み込み完了()
    func 読み込み成功(weatherInfo: WeatherInfo)
    func 読み込み失敗()
}
