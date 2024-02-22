//
//  WeatherPresenterTests.swift
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

@MainActor
final class WeatherPresenterTests: XCTestCase {
    // MARK: - Properties
    
    /// API通信の待機時間
    let apiTimeout: Double = 0.1
    
    // MARK: - Tests
    
    func test_曇りの画像を表示する() throws {
        let vc = SpyWeatherViewController()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let presenter: WeatherPresenterInput = WeatherPresenter(view: vc, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        vc.showWeatherInfoExpectation = expectation
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .cloudy)
        presenter.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
        XCTAssertEqual(vc.receivedWeatherInfo?.weather, .cloudy)
    }
    
    func test_雨の画像を表示する() throws {
        let vc = SpyWeatherViewController()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let presenter: WeatherPresenterInput = WeatherPresenter(view: vc, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        vc.showWeatherInfoExpectation = expectation
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .rainy)
        presenter.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
        XCTAssertEqual(vc.receivedWeatherInfo?.weather, .rainy)
    }
    
    func test_晴れの画像を表示する() throws {
        let vc = SpyWeatherViewController()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let presenter: WeatherPresenterInput = WeatherPresenter(view: vc, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        vc.showWeatherInfoExpectation = expectation
        
        // 更新ボタンを押して天気を読み込む
        weatherInfoRepository.willFetch = .make(weather: .sunny)
        presenter.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
        XCTAssertEqual(vc.receivedWeatherInfo?.weather, .sunny)
    }
    
    func test_取得した最高気温と最低気温を表示する() throws {
        let vc = SpyWeatherViewController()
        let weatherInfoRepository = SpyWeatherInfoRepository()
        let presenter: WeatherPresenterInput = WeatherPresenter(view: vc, weatherInfoRepository: weatherInfoRepository)
        
        let expectation = expectation(description: "読み込みが終わるまで待機")
        vc.showWeatherInfoExpectation = expectation
        
        // 更新ボタンを押して気温を読み込む
        weatherInfoRepository.willFetch = .make(highTemperature: 20, minimumTemperature: 10)
        presenter.didTapReloadButton()
        wait(for: [expectation], timeout: apiTimeout)
        XCTAssertEqual(vc.receivedWeatherInfo?.highTemperature, 20)
        XCTAssertEqual(vc.receivedWeatherInfo?.minimumTemperature, 10)
    }
}
