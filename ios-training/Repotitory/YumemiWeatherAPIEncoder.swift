//
//  YumemiWeatherAPIEncoder.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import Foundation

/// YumemiWeather のクエリのエンコードを行う
struct YumemiWeatherAPIEncoder {
    // MARK: Internal
    
    /// `YumemiWeather.fetchWeather(_:)` のクエリをJSON文字列にエンコードする
    /// - throws: エンコードに失敗した場合はそれに対応するエラーを投げる
    func encodeQuery(at areas: [String], date: Date) throws -> String {
        let query = Query(areas: areas, date: date)
        let queryData = try Self.encoder.encode(query)
        return String(data: queryData, encoding: .utf8)!
    }
}

// MARK: - Private

private extension YumemiWeatherAPIEncoder {
    struct Query: Encodable {
        let areas: [String]
        let date: Date
    }
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}
