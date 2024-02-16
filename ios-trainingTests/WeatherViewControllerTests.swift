//
//  WeatherViewControllerTests.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

final class WeatherViewControllerTests: XCTestCase {
    func test_取得した各天気に対応する画像を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository(
            willFetch: WeatherInfo(weather: .cloudy, highTemperature: 20, minimumTemperature: 10)
        )
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して天気を読み込む - 曇り
        vc.didTapReloadButton()
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .cloudy)
        )
        
        // 更新ボタンを押して天気を読み込む - 雨
        weatherInfoRepository.willFetch = WeatherInfo(weather: .rainy, highTemperature: 20, minimumTemperature: 10)
        vc.didTapReloadButton()
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .rainy)
        )
        
        // 更新ボタンを押して天気を読み込む - 晴れ
        weatherInfoRepository.willFetch = WeatherInfo(weather: .sunny, highTemperature: 20, minimumTemperature: 10)
        vc.didTapReloadButton()
        XCTAssertEqual(
            view.weatherImageView.image,
            UIImage(resource: .sunny)
        )
    }
    
    func test_取得した最高気温と最低気温を表示する() throws {
        let view = SpyWeatherView()
        let weatherInfoRepository = SpyWeatherInfoRepository(
            willFetch: WeatherInfo(weather: .cloudy, highTemperature: 20, minimumTemperature: 10)
        )
        let vc = WeatherViewController(view: view, weatherInfoRepository: weatherInfoRepository)
        
        // 更新ボタンを押して天気を読み込む
        vc.didTapReloadButton()
        XCTAssertEqual(view.highTemperatureLabel.text, "20")
        XCTAssertEqual(view.minimumTemperatureLabel.text, "10")
    }
}
