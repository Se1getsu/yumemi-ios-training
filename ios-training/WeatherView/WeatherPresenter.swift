//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

@MainActor
final class WeatherPresenter {
    // MARK: Properties
    
    private let area: Area
    
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(
        view: WeatherPresenterOutput,
        weatherInfoRepository: WeatherInfoRepositoryProtocol,
        area: Area,
        weatherInfo: WeatherInfo?
    ) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
        self.area = area
        if let weatherInfo {
            self.view.showWeatherInfo(weatherInfo: weatherInfo)
        }
    }
}

// MARK: - WeatherPresenterInput

extension WeatherPresenter: WeatherPresenterInput {
    func willEnterForeground() {
        loadWeather()
    }
    
    func didTapCloseButton() {
        view.dismiss()
    }
    
    func didTapReloadButton() {
        loadWeather()
    }
    
    func didTapRetry() {
        loadWeather()
    }
}

// MARK: - Private

private extension WeatherPresenter {
    /// 天気を読み込む
    func loadWeather() {
        view.startLoading()
        Task {
            defer {
                view.finishLoading()
            }
            do {
                let weatherInfo = try await self.weatherInfoRepository.fetch(at: [area], date: Date())[area]!
                view.showWeatherInfo(weatherInfo: weatherInfo)
            } catch {
                view.showFetchErrorAlert()
            }
        }
    }
}
