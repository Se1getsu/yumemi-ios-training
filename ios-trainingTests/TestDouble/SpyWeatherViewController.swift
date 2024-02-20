//
//  SpyWeatherViewController.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

class SpyWeatherViewController: WeatherPresenterOutput {
    // MARK: Properties - Output
    
    var receivedWeatherInfo: WeatherInfo?
    
    // MARK: Properties - Expectations
    
    var showWeatherInfoExpectation: XCTestExpectation?
    
    func dismiss() {
    }
    
    func startLoading() {
    }
    
    func finishLoading() {
    }
    
    func showWeatherInfo(weatherInfo: WeatherInfo) {
        guard let showWeatherInfoExpectation else {
            XCTFail()
            return
        }
        receivedWeatherInfo = weatherInfo
        showWeatherInfoExpectation.fulfill()
    }
    
    func showFetchErrorAlert() {
    }
}
