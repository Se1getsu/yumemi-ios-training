//
//  SpyWeatherInfoRepository.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import Foundation
@testable import ios_training

final class SpyWeatherInfoRepository {
    // MARK: Input
    
    var areaInput: String? = nil
    var dateInput: Date? = nil
    
    // MARK: Output
    
    var willFetch: WeatherInfo!
}

// MARK: - WeatherInfoRepository

extension SpyWeatherInfoRepository: WeatherInfoRepository {
    func fetch(at area: String, date: Date) throws -> WeatherInfo {
        areaInput = area
        dateInput = date
        return willFetch
    }
}
