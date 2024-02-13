//
//  MainViewController.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: 依存
    private let myView = MainView()
    
    // MARK: メソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
    }
}
