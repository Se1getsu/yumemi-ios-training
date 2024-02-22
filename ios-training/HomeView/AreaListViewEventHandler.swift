//
//  AreaListViewEventHandler.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/21.
//

import Foundation

protocol AreaListViewEventHandler: AnyObject {
    /// 画面に表示する地域のリスト
    var areas: [Area] { get }
    
    /// 特定の地域の天気に関する情報を取得する
    func weatherInfoAt(_ area: Area) -> WeatherInfo?
    
    /// セルがタップされた時の処理
    func didSelectRowAt(_ index: Int)
    
    /// Pull-to-Refreshの処理
    func onRefresh()
}
