//
//  YumemiWeatherAPIEncoderTests.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import XCTest
@testable import ios_training

final class YumemiWeatherAPIEncoderTests: XCTestCase {
    // MARK: Parameters
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/mm/dd HH:mm:ss"
        return formatter
    }()
    
    // MARK: Tests
    
    func test_クエリをエンコード() throws {
        let encoder = YumemiWeatherAPIEncoder()
        let jsonString = try encoder.encodeQuery(
            at: [.Tokyo],
            date: formatter.date(from: "2024/02/16 12:00:00")!
        )
        XCTAssertTrue([
            #"{"areas":["Tokyo"],"date":"2024-01-16T03:00:00Z"}"#,
            #"{"date":"2024-01-16T03:00:00Z","areas":["Tokyo"]}"#
        ].contains(jsonString))
    }
}
