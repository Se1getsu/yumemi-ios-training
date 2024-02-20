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
    let apiInterval: Double = 0.1
    
    // MARK: - Tests
    
    func test_曇りの画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .cloudy)
        vc.didTapReloadButton()
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが終わるまで待機")], timeout: apiInterval)
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .cloudy)
        )
    }
    
    func test_雨の画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .rainy)
        vc.didTapReloadButton()
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが終わるまで待機")], timeout: apiInterval)
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .rainy)
        )
    }
    
    func test_晴れの画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .sunny)
        vc.didTapReloadButton()
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが終わるまで待機")], timeout: apiInterval)
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .sunny)
        )
    }
    
    func test_取得した最高気温と最低気温を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して気温を読み込む
        weatherInfoRepository.willFetch = .make(highTemperature: 20, minimumTemperature: 10)
        vc.didTapReloadButton()
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが終わるまで待機")], timeout: apiInterval)
        XCTAssertEqual(view.highTemperatureLabel.text, "20")
        XCTAssertEqual(view.minimumTemperatureLabel.text, "10")
    }
}
