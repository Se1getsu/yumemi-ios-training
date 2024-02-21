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
    
    /// セルがタップされた時の処理
    func didSelectRowAt(_ index: Int)
}
