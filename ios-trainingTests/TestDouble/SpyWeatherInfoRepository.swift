//
//  SpyWeatherInfoRepository.swift
//  ios-trainingTests
//
//  Created by 垣本 桃弥 on 2024/02/16.
//

import Foundation
@testable import ios_training

final class SpyWeatherInfoRepository {
    // MARK: Properties - Input
    
    var areasInput: [Area]? = nil
    var dateInput: Date? = nil
    
    // MARK: Properties - Output
    
    var willFetch: [Area: WeatherInfo]!
}

// MARK: - WeatherInfoRepository

extension SpyWeatherInfoRepository: WeatherInfoRepositoryProtocol {
    func fetch(at areas: [Area], date: Date) async throws -> [Area : WeatherInfo] {
        areasInput = areas
        dateInput = date
        return willFetch
    }
}
