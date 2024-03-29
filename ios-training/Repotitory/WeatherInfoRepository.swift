//
//  WeatherInfoRepository.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import Foundation
import YumemiWeather

/// YumemiWeather から天気に関する情報を取得するリポジトリ
struct WeatherInfoRepository: WeatherInfoRepositoryProtocol {
    // MARK: Properties - Dependencies
    
    private let apiEncoder: YumemiWeatherAPIEncoder
    private let apiDecoder: YumemiWeatherAPIDecoder
    
    // MARK: Lifecycle
    
    init(apiEncoder: YumemiWeatherAPIEncoder, apiDecoder: YumemiWeatherAPIDecoder) {
        self.apiEncoder = apiEncoder
        self.apiDecoder = apiDecoder
    }
    
    // MARK: Internal
    
    /// 天気に関する情報を取得する
    /// - throws: 取得に失敗した場合は YumemiWeatherError を投げる
    /// - throws: エンコードやデコードに失敗した場合はそれに対応するエラーを投げる
    func fetch(at areas: [Area], date: Date) async throws -> [Area: WeatherInfo] {
        let query = try apiEncoder.encodeQuery(at: areas, date: date)
        let response = try await YumemiWeather.asyncFetchWeatherList(query)
        return try apiDecoder.decodeResponse(response)
    }
}
