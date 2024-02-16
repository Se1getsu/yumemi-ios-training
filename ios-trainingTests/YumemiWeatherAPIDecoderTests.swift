//
//  YumemiWeatherAPIDecoderTests.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

final class YumemiWeatherAPIDecoderTests: XCTestCase {
    // MARK: Parameters
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/mm/dd HH:mm:ss"
        return formatter
    }()
    
    // MARK: Tests
    
    func test_クエリをデコード() throws {
        let decoder = YumemiWeatherAPIDecoder()
        let jsonString = #"{"max_temperature":25,"date":"2020-04-01T12:00:00+09:00","min_temperature":7,"weather_condition":"cloudy"}"#
        let weatherInfo = try decoder.decodeResponse(jsonString)
        XCTAssertEqual(weatherInfo.weather, .cloudy)
        XCTAssertEqual(weatherInfo.highTemperature, 25)
        XCTAssertEqual(weatherInfo.minimumTemperature, 7)
    }
}
