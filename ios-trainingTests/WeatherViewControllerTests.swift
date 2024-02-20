//
//  WeatherViewControllerTests.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

// MARK: - Extension

private extension WeatherInfo {
    static func make(
        weather: Weather = .cloudy,
        highTemperature: Int = 20,
        minimumTemperature: Int = 10
    ) -> Self {
        WeatherInfo(weather: weather, highTemperature: highTemperature, minimumTemperature: minimumTemperature)
    }
}

// MARK: - WeatherViewControllerTests

final class WeatherViewControllerTests: XCTestCase {
    // MARK: - Properties
    
    /// API通信の待機時間
    let apiTimeout: Double = 0.1
    
    /// API通信完了の確認の間隔
    let apiInterval: Double = 0.01
    
    // MARK: - Tests
    
    func test_曇りの画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        Timer.scheduledTimer(withTimeInterval: apiInterval, repeats: true) { timer in
            guard view.weatherImageView.image == UIImage(resource: .cloudy) else { return }
            expectation.fulfill()
            timer.invalidate()
        }
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .cloudy)
        vc.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
    }
    
    func test_雨の画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        Timer.scheduledTimer(withTimeInterval: apiInterval, repeats: true) { timer in
            guard view.weatherImageView.image == UIImage(resource: .rainy) else { return }
            expectation.fulfill()
            timer.invalidate()
        }
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .rainy)
        vc.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
    }
    
    func test_晴れの画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        Timer.scheduledTimer(withTimeInterval: apiInterval, repeats: true) { timer in
            guard view.weatherImageView.image == UIImage(resource: .sunny) else { return }
            expectation.fulfill()
            timer.invalidate()
        }
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .sunny)
        vc.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
    }
    
    func test_取得した最高気温と最低気温を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        Timer.scheduledTimer(withTimeInterval: apiInterval, repeats: true) { timer in
            guard view.highTemperatureLabel.text == "20" else { return }
            guard view.minimumTemperatureLabel.text == "10" else { return }
            expectation.fulfill()
            timer.invalidate()
        }
        
        // 更新ボタンを押して気温を読み込む
        weatherInfoRepository.willFetch = .make(highTemperature: 20, minimumTemperature: 10)
        vc.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
    }
}
