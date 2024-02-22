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
    // MARK: Properties
    
    weak var delegate: WeatherInfoRepositoryDelegate?
    
    // MARK: Dependencies
    
    private let apiEncoder: YumemiWeatherAPIEncoder
    private let apiDecoder: YumemiWeatherAPIDecoder
    
    // MARK: Lifecycle
    
    init(apiEncoder: YumemiWeatherAPIEncoder, apiDecoder: YumemiWeatherAPIDecoder) {
        self.apiEncoder = apiEncoder
        self.apiDecoder = apiDecoder
    }
    
    // MARK: Internal
    
    /// 天気に関する情報を取得をリクエストする
    func requestFetch(at area: String, date: Date) {
        DispatchQueue.global().async {
            do {
                let query = try apiEncoder.encodeQuery(at: area, date: date)
                let response = try YumemiWeather.syncFetchWeather(query)
                let weatherInfo = try apiDecoder.decodeResponse(response)
                delegate?.didFetch(result: .success(weatherInfo))
            } catch {
                delegate?.didFetch(result: .failure(error))
            }
        }
    }
}
