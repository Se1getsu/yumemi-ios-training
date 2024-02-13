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
    private let weatherRepository: WeatherRepository
    private let weatherImageRepository: WeatherImageRepository
    
    // MARK: メソッド
    init(weatherRepository: WeatherRepository, weatherImageRepository: WeatherImageRepository) {
        self.weatherRepository = weatherRepository
        self.weatherImageRepository = weatherImageRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = myView
        loadWeather()
        
        myView.reloadButton.addTarget(self, action: #selector(didTapReloadButton), for: .touchUpInside)
    }
    
    @objc func didTapReloadButton() {
        loadWeather()
    }
}

private extension MainViewController {
    /// 天気を読み込む
    func loadWeather() {
        let weather = weatherRepository.fetch()
        myView.weatherImageView.image = weatherImageRepository.image(for: weather)
        myView.weatherImageView.tintColor = weather.imageTint
    }
}
