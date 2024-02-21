//
//  SpyWeatherViewController.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

class SpyWeatherViewController {
    // MARK: Properties - Output
    
    var receivedWeatherInfo: WeatherInfo?
    
    // MARK: Properties - Expectations
    
    var showWeatherInfoExpectation: XCTestExpectation?
}

// MARK: WeatherPresenterOutput

extension SpyWeatherViewController: WeatherPresenterOutput {
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
