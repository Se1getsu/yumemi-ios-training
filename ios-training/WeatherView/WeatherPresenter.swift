//
//  WeatherPresenter.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import Foundation

final class WeatherPresenter: WeatherPresenterInput {
    // MARK: Properties - Dependencies
    
    private weak var view: WeatherPresenterOutput!
    private var weatherInfoRepository: WeatherInfoRepositoryProtocol
    
    // MARK: Lifecycle
    
    init(view: WeatherPresenterOutput, weatherInfoRepository: WeatherInfoRepositoryProtocol) {
        self.view = view
        self.weatherInfoRepository = weatherInfoRepository
    }
    
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
                let weatherInfo = try await self.weatherInfoRepository.fetch(at: "tokyo", date: Date())
                view.showWeatherInfo(weatherInfo: weatherInfo)
            } catch {
                view.showFetchErrorAlert()
            }
        }
    }
}
