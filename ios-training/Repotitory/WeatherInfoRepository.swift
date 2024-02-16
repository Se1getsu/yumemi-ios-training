//
//  WeatherInfoRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation
import YumemiWeather

/// YumemiWeather から天気に関する情報を取得するリポジトリ
struct WeatherInfoRepository {
    // MARK: Errors
    
    enum APIError: Error {
        /// `Weather`に未定義の天気を取得した場合のエラー
        case undefinedWeather
    }
    
    // MARK: Internal
    
    /// 天気に関する情報を取得する
    /// - throws: 取得に失敗した場合は YumemiWeatherError を投げる
    /// - throws: 予期せぬものを取得した場合は WeatherRepository.APIError を投げる
    /// - throws: エンコードやデコードに失敗した場合はそれに対応するエラーを投げる
    func fetch(at area: String, date: Date) throws -> WeatherInfo {
        let query = APIQuery(area: area, date: date)
        let queryJSONString = try encodeQuery(query)
        let responseJSONString = try YumemiWeather.fetchWeather(queryJSONString)
        let response = try decodeResponse(responseJSONString)
        return try response.convertToEntity()
    }
}

// MARK: - Private

private extension WeatherInfoRepository {
    /// YumemiWeather.fetchWeather のクエリ
    struct APIQuery: Encodable {
        let area: String
        let date: Date
    }
    
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
                highTemperature: maxTemperature,
                minimumTemperature: minTemperature
            )
        }
    }
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private static let decoder: JSONDecoder = {
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        decorder.dateDecodingStrategy = .iso8601
        return decorder
    }()
    
    /// クエリをJSON文字列にエンコードする
    func encodeQuery(_ query: APIQuery) throws -> String {
        let queryData = try WeatherInfoRepository.encoder.encode(query)
        return String(data: queryData, encoding: .utf8)!
    }
    
    /// JSON文字列をレスポンスの型にデコードする
    func decodeResponse(_ jsonString: String) throws -> APIResponse {
        let data = jsonString.data(using: .utf8)!
        return try WeatherInfoRepository.decoder.decode(APIResponse.self, from: data)
    }
}
