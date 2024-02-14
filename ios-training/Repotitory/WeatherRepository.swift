//
//  WeatherRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation
import YumemiWeather

/// YumemiWeather から天気を取得するリポジトリ
struct WeatherRepository {
    // MARK: Errors
    
    enum APIError: Error {
        /// `Weather`に未定義の天気を取得した場合のエラー
        case undefinedWeather
    }
    
    // MARK: Internal
    
    /// 天気を取得する
    /// - throws: 取得に失敗した場合は YumemiWeatherError、予期せぬものを取得した場合は WeatherRepository.APIError を返す
    func fetch(at area: String, date: Date) throws -> WeatherInfo {
        let query = WeatherAPIQuery(area: area, date: date)
        let queryJSONString = try encodeQuery(query)
        let responseJSONString = try YumemiWeather.fetchWeather(queryJSONString)
        let response = try decodeResponse(responseJSONString)
        guard let weatherInfo = WeatherInfo(from: response) else {
            throw APIError.undefinedWeather
        }
        return weatherInfo
    }
}

private extension WeatherRepository {
    // MARK: Private
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return dateFormatter
    }()
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        decorder.dateDecodingStrategy = .formatted(dateFormatter)
        return decorder
    }()
    
    func encodeQuery(_ query: WeatherAPIQuery) throws -> String {
        let queryData = try WeatherRepository.encoder.encode(query)
        return String(data: queryData, encoding: .utf8)!
    }
    
    func decodeResponse(_ jsonString: String) throws -> WeatherAPIResponse {
        let data = jsonString.data(using: .utf8)!
        return try WeatherRepository.decoder.decode(WeatherAPIResponse.self, from: data)
    }
}
