//
//  YumemiWeatherAPIDecoder.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import Foundation

/// YumemiWeather のレスポンスのデコードを行う
struct YumemiWeatherAPIDecoder {
    // MARK: Errors
    
    enum APIError: Error {
        /// `Weather`に未定義の天気を取得した場合のエラー
        case undefinedWeather
    }
    
    // MARK: Internal
    
    /// `YumemiWeather.fetchWeather(_:)` のレスポンスをエンティティにデコードする
    /// - throws: 予期せぬものを取得した場合は WeatherRepository.APIError を投げる
    func decodeResponse(_ jsonString: String) throws -> WeatherInfo {
        let data = jsonString.data(using: .utf8)!
        let response = try Self.decoder.decode(APIResponse.self, from: data)
        return try response.convertToEntity()
    }
}

// MARK: - Private

private extension YumemiWeatherAPIDecoder {
    /// YumemiWeather.fetchWeather のレスポンス
    struct APIResponse: Decodable {
        let date: Date
        let weatherCondition: String
        let maxTemperature: Int
        let minTemperature: Int
        
        func convertToEntity() throws -> WeatherInfo {
            guard let weather = Weather(rawValue: weatherCondition) else {
                throw APIError.undefinedWeather
            }
            return WeatherInfo(
                weather: weather,
                highestTemperature: maxTemperature,
                lowestTemperature: minTemperature
            )
        }
    }
    
    private static let decoder: JSONDecoder = {
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        decorder.dateDecodingStrategy = .iso8601
        return decorder
    }()
}
