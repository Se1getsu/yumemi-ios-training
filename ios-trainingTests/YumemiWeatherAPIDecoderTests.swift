//
//  YumemiWeatherAPIDecoderTests.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

final class YumemiWeatherAPIDecoderTests: XCTestCase {
    func test_レスポンスをデコード() throws {
        let decoder = YumemiWeatherAPIDecoder()
        let jsonString = #"[{"area":"Tokyo","info":{"max_temperature":25,"date":"2020-04-01T12:00:00+09:00","min_temperature": 7,"weather_condition":"cloudy"}}]"#
        let weatherInfos = try decoder.decodeResponse(jsonString)
        XCTAssertEqual(weatherInfos.keys.count, 1)
        XCTAssertNotNil(weatherInfos[.Tokyo])
        XCTAssertEqual(weatherInfos[.Tokyo]!.highTemperature, 25)
        XCTAssertEqual(weatherInfos[.Tokyo]!.minimumTemperature, 7)
    }
}
